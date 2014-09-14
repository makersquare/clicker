require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  before do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @student = User.create(
      provider: "github",
      uid: "9999999",
      name: "Catelyn Tully",
      nickname: "Cat",
      verified: false
    )
    @teacher = User.create(
      provider: "github",
      uid: "1111111",
      name: "Ed Stark",
      nickname: "Ned",
      verified: true
    )
    @classgroup = ClassGroup.create(
      name: "Cohort 8, The Ocho",
      description: "MKS immersive course"
    )
    @question_set = QuestionSet.create(
      class_group_id: 1,
      name: "Algorithms"
    )

    @attendance_question = AttendanceQuestion.create(
      question_set_id: 1,
      content: {
            question: "Attendance Check",
            answer: "true"
          }
    )

    @multi_choice_question = MultiChoiceQuestion.create(
      question_set_id: 1,
      content: {
            question: "How many children can a node of a binary tree have?",
            answer: "D",
            choices: [
              { "A" => "0" },
              { "B" => "1" },
              { "C" => "2" },
              { "D" => "0, 1, or 2" }
            ]
          }
    )

    @short_answer_question = ShortAnswerQuestion.create(
      question_set_id: 1,
      content: {
            question: "What rule separates a binary search tree from a regular binary tree?",
            answer: "All children to the left of the node must be smaller than the node, and all children to the right must be larger."
          }
    )
  end

  describe 'GET #index' do
    it "responds successfully with an HTTP 200 status code" do
      get :index, {question_set_id: @question_set.id}, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it "responds successfully with an HTTP 200 status code" do
      get :show, {question_set_id: @question_set.id, id: @multi_choice_question.id}, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "allows verified accounts" do
      User.create(:verified => true)
      # Sign in the user
      count = ClassGroup.all.count
      post :create, {classgroup_id: @classgroup.id}
      expect(count).to eq(1)
    end
end


end

