require 'rails_helper'

RSpec.describe QuestionSetsController, :type => :controller do
  
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
      count = QuestionSet.all.count
      question_set_name = QuestionSet.find(@question_set.id).name
      post :create, { 
        class_group_id: @class_group.id
        # id: @question_set.id,
        # name: @question_set.name
        }
      expect(count).to eq(1)
      expect(question_set_name).to eq("Lambda Calculus")
    end
  end

  describe "PATCH/PUT #update" do
    it "updates already created question set" do
      
    end
  end




















end
