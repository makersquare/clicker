require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do
  render_views

  before do
    request.env["HTTP_ACCEPT"] = 'application/json'

    @student = Fabricate(:user)
    @teacher = Fabricate(:verified_user)
    @classgroup = Fabricate(:class_group)
    @question_set = Fabricate(:question_set, class_group_id: @classgroup.id)
    @attendance_question = Fabricate(:attendance_question, question_set_id: @question_set.id)
    @multi_choice_question = Fabricate(:multi_choice_question, question_set_id: @question_set.id)
    @short_answer_question = Fabricate(:short_answer_question, question_set_id: @question_set.id)
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
    context "with valid attributes" do
      it "creates a new question" do
        valid_params = {content: {question: "True or False", answer: "False"}}
        expect {
          post :create, {question_set_id: @question_set.id, question: valid_params}, {user_id: @teacher.id}
        }.to change(Question, :count).by(1)
      end

      it "creates a new question" do
        params = {"question_sets_id"=>@question_set.id, "question"=>{"type"=>"MultiChoiceQuestion", "content"=>{"question"=>"Test Q", "answer"=>"0", "choices"=>["a", "b", "c", "d"]}}, "question_set_id"=>@question_set.id}
        post :create, params, {user_id: @teacher.id}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "updates a question" do
        updated_question = {
          "question" => "How many children can a node of a binary tree have?",
          # Note: Answer is a string because in Angular UI you are sending a JSON string for update!
          "answer" => "1", 
          "choices" => [
              "8",
              "0, 1, or 2"
            ]
          }
        valid_params = { content: updated_question }
        put :update, { question_set_id: @question_set.id, id: @multi_choice_question.id, question: valid_params } , {user_id: @teacher.id}
        @multi_choice_question.reload
        expect(@multi_choice_question.content).to eq(updated_question)
      end
    end
  end

  describe "POST #delete" do
    it "deletes the question" do
      expect{
        delete :destroy, {question_set_id: @question_set.id, id: @multi_choice_question.id}, {user_id: @teacher.id}
      }.to change(Question, :count).by(-1)
    end
  end

end

