require 'rails_helper'

RSpec.describe ResponsesController, :type => :controller do
  render_views

  before do
    request.env["HTTP_ACCEPT"] = 'application/json'

    @studenta = Fabricate(:user)
    @studentb = Fabricate(:user)
    @teacher = Fabricate(:verified_user)
    @classgroup = Fabricate(:class_group)

    @classgroup.memberships.create(
      user_id: @studenta.id,
      kind: 'student'
    )
    @classgroup.memberships.create(
      user_id: @studentb.id,
      kind: 'student'
    )
    @classgroup.memberships.create(
      user_id: @teacher.id,
      kind: 'teacher'
    )
    #####1ST QUESTION SET WITH TWO QUESTIONS WITH TWO RESPONSES EACH#####
    @questionset = Fabricate(:question_set, class_group_id: @classgroup.id)
    @question1 = Fabricate(:multi_choice_question, question_set_id: @questionset.id)
    @response1a = Fabricate(:response, question_id: @question1.id, content: {response: "D"})
    @response1b = Fabricate(:response, question_id: @question1.id)
    @question2 = Fabricate(:short_answer_question, question_set_id: @questionset.id)
    @response2a = Fabricate(:response, question_id: @question2.id)
    @response2b = Fabricate(:response, question_id: @question2.id)

    #####2ND QUESTION SET WITH ONE QUESTION WITH TWO RESPONSES#####
    @anotherquestionset = Fabricate(:question_set, class_group_id: @classgroup.id)
    @anotherquestion = Fabricate(:attendance_question, question_set_id: @anotherquestionset.id)
    @anotherresponsea = Fabricate(:response, question_id: @anotherquestion.id)
    @anotherresponseb = Fabricate(:response, question_id: @anotherquestion.id)    
  end

  describe 'GET #show' do
    before do
      get :show, {question_set_id: @questionset, question_id: @question1, id: @response1a}, {user_id: @studenta}
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end 

    it 'renders show template' do
      expect(response).to render_template(:show)
    end   

    it "assigns @response" do
      expect(assigns(:response)).to eq(@response1a)
    end
  end

  describe 'GET #index' do
    before do
      get :index, {question_set_id: @questionset.id, question_id: @question1.id}, {user_id: @studenta}
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end    

    it 'renders index template' do
      expect(response).to render_template(:index)
    end   

    it "assigns @responses to only include responses to correct question" do
      expect(assigns(:responses)).to include(@response1a)
      expect(assigns(:responses)).to include(@response1b)
      expect(assigns(:responses)).to_not include(@anotherresponsea)
      expect(assigns(:responses)).to_not include(@response2a)
    end    
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it "creates a new response" do 
        valid_params = {content: {response: "D"}}
        expect {
          post :create, {question_set_id: @questionset, question_id: @question1, response: valid_params}, {user_id: @studenta}
        }.to change(Response, :count).by(1)
      end

      it "notifies its existence", :no_database_cleaner => true do
        valid_params = {content: {response: "D"}}
        id = @studenta.id
        expect {
          post :create, {question_set_id: @questionset, question_id: @question1, response: valid_params, user_id: @studenta.id}, {user_id: @studenta}
        }.to notify('new_responses') {|payload|
          data = JSON.parse(payload)
          expect(data["question_id"]).to eq @question1.id
          expect(data["user_id"]).to eq @studenta.id
        }
      end
    end

    it "does not allow student to submit response for another student" do
      #studentb logged in; studenta id in params for response#create
      params = {content: {response: "D", user_id: @studenta.id}}
      post :create, {question_set_id: @questionset, question_id: @question1, response: params, user_id: @studenta.id}, {user_id: @studentb}
      student_a_response = Response.where(question_id: @question1.id, user_id: @studenta.id)
      student_b_response = Response.where(question_id: @question1.id, user_id: @studentb.id)
      expect(student_a_response.length).to eq(0)
      expect(student_b_response.length).to eq(1)
    end

    it "does not allow teachers to submit a response" do
      params = {content: {response: "D", user_id: @teacher.id}}
      expect {
        post :create, 
          {question_set_id: @questionset, 
          question_id: @question1, 
          response: params, user_id: @teacher.id}, 
          {user_id: @teacher}
      }.to change(Response, :count).by(0)
    end

    it "does not allow users who are not part of the class to submit a response" do
      unenrolled_student = Fabricate(:user)
      params = {content: {response: "D", user_id: unenrolled_student.id}}
      expect {
        post :create, 
          {question_set_id: @questionset, 
          question_id: @question1, 
          response: params, user_id: unenrolled_student.id}, 
          {user_id: unenrolled_student}
      }.to change(Response, :count).by(0)
    end    

    context 'with invalid attributes' do
      it "does not create a new response" do
        invalid_params = {invalid: "D"}
          expect {
            post :create, {question_set_id: @questionset, question_id: @question1, response: invalid_params}, {user_id: @studenta}
          }.to change(Response, :count).by(0)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it "updates a response" do 
        expect(@response1a.content).to eq({"response" => "D"})        
        valid_params = {content: {response: "updated answer"}}
        put :update, {question_set_id: @questionset, question_id: @question1, id: @response1a, response: valid_params}, {user_id: @studenta}
        @response1a.reload
        expect(response).to be_success
        expect(@response1a.content).to eq({"response" => "updated answer"})
      end
    end

    context 'with invalid attributes' do
      it "does not update a response" do
        expect(@response1a.content).to eq({"response" => "D"})        
        invalid_params = {content: "D"}
        put :update, {question_set_id: @questionset, question_id: @question1, id: @response1a, response: invalid_params}, {user_id: @studenta}
        @response1a.reload
        expect(@response1a.content).to eq({"response" => "D"})
      end
    end
  end
end