require 'rails_helper'


RSpec.describe "student flow" do
  
  before do
    @student = Fabricate(:user, class_groups: [
      Fabricate(:class_group, question_sets: [
        Fabricate(:question_set),
        Fabricate(:question_set, active: true, questions: [
          Fabricate(:attendance_question),
          Fabricate(:multi_choice_question),
          Fabricate(:multi_choice_question)
        ])
      ]), 
      Fabricate(:class_group)
    ])
  end

  let(:session) do
    { user_id: @student.id }
  end  

  it 'directs them to the sign in page' do
    get '/'
    expect(response).to render_template(:index)
  end

  describe 'github' do
    it "should login with github", :js => true do
      get "/test_sign_in/#{@student.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
    end
  end

  context 'when student accesses site' do
    it 'allows a student to sign in with github and redirects to their list of classes then individual class' do
      #accesses site
      get "/"
      expect(response).to render_template("welcome/index")
      
      #logs in & redirects to class_groups_index
      get "/test_sign_in/#{@student.id}"
      get '/'
      class1 = @student.class_groups.first
      class2 = @student.class_groups[1]
      expect(response).to redirect_to('/class_groups')
      follow_redirect!
      expect(response.body).to include(class1.name)
      expect(response.body).to include(class2.name)

      #student views 1 class group on show page and the question sets for that class
      get "/class_groups/#{class1.id}"
      expect(response).to render_template('class_groups/show')

      #if a question set is active the student can view the page for that question set
      active_qset = class1.question_sets[1]
      q1 = active_qset.questions[0]
      q2 = active_qset.questions[1]
      q3 = active_qset.questions[2]
      get "/class_groups/#{class1.id}/question_sets/#{active_qset.id}"
      expect(response).to render_template('question_sets/show')
      
      #student answers questions
      post "question_sets/#{active_qset.id}/questions/#{active_qset.id}/responses.json", :response => {
        question_id: q1.id, user_id: @student.id, content: {response: "D"}}
      post "question_sets/#{active_qset.id}/questions/#{active_qset.id}/responses.json", :response => {
        question_id: q2.id, user_id: @student.id, content: {response: "C"}}
      post "question_sets/#{active_qset.id}/questions/#{active_qset.id}/responses.json", :response => {
        question_id: q3.id, user_id: @student.id, content: {response: "A"}}
      these_responses = Response.where(user_id: @student.id)
      expect(these_responses[0].content["response"]).to eq("D")
      expect(these_responses.count).to eq(3)
    end
  end

end