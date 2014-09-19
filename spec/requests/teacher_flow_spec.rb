require 'rails_helper'

RSpec.describe 'Teacher Flow' do

  before do
    @teacher = Fabricate(:verified_user)
    @class_group = Fabricate(:class_group)
    Membership.create(kind: "teacher", user_id: @teacher.id, class_group_id: @class_group.id)
    @question_set = Fabricate(:question_set, class_group_id: @class_group.id)
  end

  let(:session) do
    { user_id: @teacher.id }
  end

  it 'directs a teacher to the sign in page' do
    get '/'
    expect(response).to render_template(:index)
  end

  it "allows a teacher to sign in with github and directs them to the class page", :js => true do
    
    # sign in teacher with github
    get "/test_sign_in/#{@teacher.id}"
    get '/'
    expect(response).to redirect_to('/class_groups')
 
    # takes teacher to show page when they click on a class group
    get "/class_groups/#{@teacher.class_groups[0].id}"
    expect(response).to render_template('class_groups/show')

    #takes teacher to question set show page after they create a question set
    get "/class_groups/#{@teacher.class_groups[0].id}/question_sets/#{@question_set.id}"
    expect(response).to render_template('question_sets/teacher_show')
    
    #allows teacher to create questions
    post "/question_sets/#{@question_set.id}/questions.json", :question => {
      question_set_id: @question_set.id, type: MultiChoiceQuestion, content: {question: "Blah", answer: "D", choices: [{"A" => "La"}, {"B" => "De"}, {"C" => "Da"}, {"D" => "Fa"}]}}
    post "/question_sets/#{@question_set.id}/questions.json", :question => {
      question_set_id: @question_set.id, type: MultiChoiceQuestion, content: {question: "Woo", answer: "A", choices: [{"A" => "La"}, {"B" => "De"}, {"C" => "Da"}, {"D" => "Fa"}]}}
    questions = Question.where(question_set_id: @question_set.id)
    expect(questions.count).to eq(2)
  end

end

