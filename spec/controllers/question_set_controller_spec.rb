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
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, { class_group_id: @class_group.id },
        { user_id: @student.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, { 
        class_group_id: @class_group.id,
        id: @question_set.id
        },
        { user_id: @student.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "creates a new question set" do
      get :show, { 
        class_group_id: @class_group.id,
        id: @question_set.id,
        name: @question_set.name
        },
        { user_id: @student.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end



















end
