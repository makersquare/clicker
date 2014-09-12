require 'rails_helper'

RSpec.describe QuestionSetsController, :type => :controller do
  
  before do
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
    @questionset = QuestionSet.create(
      class_group_id: 1,
      name: "Lambda Calculus"
    )
    @attendancecheck = AttendanceQuestion.create(
      question_set_id: 1,
      content: {
        question: "Attendance Check",
        answer: "true"
      }
    )
    @multchoicquestion = MultiChoiceQuestion.create(
    {
      question_set_id: 1,
      content: {
        question: "Who invented Lambda Calculus?",
        answer: "A",
        choices: [
          { "A" => "Alonzo Church" },
          { "B" => "Linus Torvalds" },
          { "C" => "Gabe Newell" },
          { "D" => "Histocles" }
        ]
      }
    },
    {
      question_set_id: 1,
      content: {
        question: "Lisp is not built on the concepts of lambda calculus.",
        answer: "false"
      }
    }
    )
  end


  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, nil, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end




















end