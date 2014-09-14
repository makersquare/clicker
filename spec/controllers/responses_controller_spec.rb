require 'rails_helper'

RSpec.describe ResponsesController, :type => :controller do

  before do
    request.env["HTTP_ACCEPT"] = 'application/json'

    @studenta = User.create(
      provider: "github",
      uid: "9999999",
      name: "Catelyn Tully",
      nickname: "Cat",
      verified: false,
      gravatar_id: "a4af3797c372cf36817f6767cefccc98"
    )
    @studentb = User.create(
      provider: "github",
      uid: "9999998",
      name: "Molly Miller",
      nickname: "mole",
      verified: false,
      gravatar_id: "a4af3797c372cf36817f6767cefccc98"
    )
    @teacher = User.create(
      provider: "github",
      uid: "1111111",
      name: "Ed Stark",
      nickname: "Ned",
      verified: true,
      gravatar_id: "687058c0dcf54250a1dfef3515bbc2a7"      
    )
    @classgroup = ClassGroup.create(
      name: "Cohort 8, The Ocho",
      description: "MKS immersive course"
    )

    Membership.create(
      user_id: @studenta.id,
      class_group_id: @classgroup.id,
      kind: 'student'
    )
    Membership.create(
      user_id: @studentb.id,
      class_group_id: @classgroup.id,
      kind: 'student'
    )
    Membership.create(
      user_id: @teacher.id,
      class_group_id: @classgroup.id,
      kind: 'teacher'
    )
    #####1ST QUESTION SET WITH TWO QUESTIONS WITH TWO RESPONSES EACH#####
    @questionset = QuestionSet.create(
      class_group_id: @classgroup.id,
      name: "RSpec testing"
    )
    @question1 = MultiChoiceQuestion.create(
      question_set_id: @questionset.id
    )
    @response1a = Response.create(
      question_id: @question1.id,
      user_id: @studenta.id,
      content: {"response"=>"D"}   
    )
    @response1b = Response.create(
      question_id: @question1.id,
      user_id: @studentb.id,
      content: {"response"=>"C"}   
    )
    @question2 = ShortAnswerQuestion.create(
      question_set_id: @questionset.id
    )
    @response2a = Response.create(
      question_id: @question2.id,
      user_id: @studenta.id,
      content: {"response"=>"Here we go!"}   
    )
    @response2b = Response.create(
      question_id: @question2.id,
      user_id: @studentb.id,
      content: {"response"=>"Woah! No way!"}   
    )

    #####2ND QUESTION SET WITH ONE QUESTION WITH TWO RESPONSES#####
    @anotherquestionset = QuestionSet.create(
      class_group_id: @classgroup.id,
      name: "Jasmine testing"
    )
    @anotherquestion = AttendanceQuestion.create(
      question_set_id: @anotherquestionset.id
    )
    @anotherresponsea = Response.create(
      question_id: @anotherquestion.id,
      user_id: @studenta.id,
      content: {"response"=>"true"}   
    )
    @anotherresponseb = Response.create(
      question_id: @anotherquestion.id,
      user_id: @studentb.id,
      content: {"response"=>nil}   
    )    
  end

  describe 'GET #show' do
    it "responds successfully with an HTTP 200 status code" do
      get :show, {question_set_id: @questionset, question_id: @question1, id: @response1a}, {user_id: @studenta}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end 

    it 'renders show template' do
      expect(response).to render_template(:show)
    end   
  end

  describe 'GET #index' do
    it "responds successfully with an HTTP 200 status code" do
      get :index, {question_set_id: @questionset.id, question_id: @question1.id}, {user_id: @studenta}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end    
  end

  describe 'POST #create' do
  end

  describe 'PUT #update' do
  end

  describe 'DELETE #destroy' do
  end
end