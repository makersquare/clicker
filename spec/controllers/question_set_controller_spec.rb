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
    @class_group = ClassGroup.create(
      name: "Cohort 8, The Ocho",
      description: "MKS immersive course"
    )
    @question_set = QuestionSet.create(
      class_group_id: 1,
      name: "Lambda Calculus"
    )
    @attendance_check = AttendanceQuestion.create(
      question_set_id: 1,
      content: {
        question: "Attendance Check",
        answer: "true"
      }
    )
    @mult_choice_question = MultiChoiceQuestion.create(
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
    @short_answer_question = ShortAnswerQuestion.create(
      question_set_id: 1,
      content: {
            question: "What rule separates a binary search tree from a regular binary tree?",
            answer: "All children to the left of the node must be smaller than the node, and all children to the right must be larger."
      }
    )
    @response = Response.create([
  {
    question_id: 1,
    user_id: 1,
    content: {
      response: "true"
    }
  },
  {
    question_id: 2,
    user_id: 1,
    content: {
      response: "D"
    }
  },
  {
    question_id: 3,
    user_id: 1,
    content: {
      response: "I have no idea."
    }
  }
  ])
  end


  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, nil, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end




















end