require 'rails_helper'


RSpec.describe "student flow" do
  
  before do
    @student = Fabricate(:user)
    @class_group1 = Fabricate(:class_group)
    @qset1 = Fabricate(:question_set, class_group_id: @class_group1.id)
    @qset2 = Fabricate(:question_set, class_group_id: @class_group1.id, state: 'open')
    
    @q1 = Fabricate(:attendance_question, question_set_id: @qset2.id)
    @q2 = Fabricate(:multi_choice_question, question_set_id: @qset2.id)
    @q3 = Fabricate(:multi_choice_question, question_set_id: @qset2.id)
  
    @class_group2 = Fabricate(:class_group)

    Membership.create(
      class_group_id: @class_group1.id,
      user_id: @student.id,
      kind: 'student')
    Membership.create(
      class_group_id: @class_group2.id,
      user_id: @student.id,
      kind: 'student')
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
    it 'student signs in with github, redirects to their list of classes, then individual class, then create responses' do
      #accesses site
      get "/"
      expect(response).to render_template("welcome/index")
      
      #logs in & redirects to class_groups_index
      get "/test_sign_in/#{@student.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
      follow_redirect!

      #student views 1 class group on show page and the question sets for that class
      get "/class_groups/#{@class_group1.id}"
      expect(response).to render_template('class_groups/student_show')

      #if a question set is active the student can view the page for that question set
      get "/class_groups/#{@class_group1.id}/question_sets/#{@qset2.id}"
      expect(response).to render_template('question_sets/student_show')
      
      #student answers questions
      post "question_sets/#{@qset2.id}/questions/#{@q1.id}/responses.json", :response => {
        question_id: @q1.id, user_id: @student.id, content: {response: "D"}}
      post "question_sets/#{@qset2.id}/questions/#{@q2.id}/responses.json", :response => {
        question_id: @q2.id, user_id: @student.id, content: {response: "C"}}
      post "question_sets/#{@qset2.id}/questions/#{@q3.id}/responses.json", :response => {
        question_id: @q3.id, user_id: @student.id, content: {response: "A"}}
      expect(@q1.responses.count).to eq(1)
      expect(@q2.responses.count).to eq(1)
      expect(@q3.responses.count).to eq(1)
      these_responses = Response.where(user_id: @student.id)
      expect(these_responses.count).to eq(3)

      response1 = Response.find_by(question_id: @q1.id, user_id: @student.id)
      expect(response1.content["response"]).to eq("D")
    end
  end

end