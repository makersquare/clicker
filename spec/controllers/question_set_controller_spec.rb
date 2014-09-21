require 'rails_helper'

RSpec.describe QuestionSetsController, :type => :controller do
  render_views
  
  before do
    request.env["HTTP_ACCEPT"] = 'application/json'
    @student = Fabricate(:user)
    @teacher = Fabricate(:verified_user)
    @class_group = Fabricate(:class_group)
    @class_group.memberships.create(
      kind: "student",
      user_id: @student.id)
    @class_group.memberships.create(
      kind: "teacher",
      user_id: @teacher.id
      )
    @question_set = Fabricate(:question_set, class_group_id: @class_group.id)
    @other_teacher = Fabricate(:verified_user)
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, { class_group_id: @class_group.id },
        { user_id: @student.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show for student and teachers" do
    before do
      request.env["HTTP_ACCEPT"] = 'text/html'
    end
    
    it "responds successfully with an HTTP 200 status code" do
      new_param_hash = { 
        class_group_id: @class_group.id,
        id: @question_set.id
        }
      get :show, new_param_hash, { user_id: @student.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)

      get :show, new_param_hash, { user_id: @teacher.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "creates a new question set" do
      count = QuestionSet.all.count

      new_param_hash = {
        class_group_id: @class_group.id,
        question_set: {
          name: "UX Design"
        }
      }
      post :create, new_param_hash, { user_id: @teacher.id }
      expect(QuestionSet.all.count).to eq(2)

      qset = assigns(:question_set)
      expect(qset.class_group_id).to eq @class_group.id
      expect(qset.name).to eq("UX Design")
    end

    it "cannot be created by a student" do
      new_param_hash = {
        class_group_id: @class_group.id,
        question_set: {
          name: "UX Design"
        }
      }
      expect {
        post :create, new_param_hash, { user_id: @student.id }
      }.to change(QuestionSet, :count).by(0)
    end

    it "cannot be created by a teacher of another class" do
      new_param_hash = {
        class_group_id: @class_group.id,
        question_set: {
          name: "UX Design"
        }
      }
      expect {
        post :create, new_param_hash, { user_id: @other_teacher.id }
      }.to change(QuestionSet, :count).by(0)
    end    
  end

  describe "PATCH/PUT #update" do
    it "updates already created question set" do
      question_set_name = QuestionSet.find(@question_set.id).name
      new_param_hash = { 
        class_group_id: @class_group.id, 
        id: @question_set.id,
        question_set: { 
          name: "Functional Calculus"
        }
      }
      put :update, new_param_hash, { user_id: @teacher.id }
      qset = assigns(:question_set)
      expect(qset.name).to eq("Functional Calculus")
    end

    it "cannot be updated by a student" do
      old_name = @question_set.name
      modified_params = {
        class_group_id: @class_group.id,
        id: @question_set.id,
        question_set: {
          name: "Modified Name"
        }
      }
      put :update, modified_params, { user_id: @student.id }
      qset = QuestionSet.find(@question_set.id)
      expect(qset.id).to eq(@question_set.id)
      expect(qset.name).to eq(old_name)
    end

    it "cannot be updated by a teacher of another class" do
      old_name = @question_set.name
      modified_params = {
        class_group_id: @class_group.id,
        id: @question_set.id,
        question_set: {
          name: "Changing the Name"
        }
      }
      put :update, modified_params, { user_id: @other_teacher.id }
      qset = QuestionSet.find(@question_set.id)
      expect(qset.name).to eq(old_name)
    end  
  end

  describe "DELETE #destroy" do
    it "deletes a question set" do
      new_param_hash = {
        class_group_id: @class_group.id, 
        id: @question_set.id
      }
      delete :destroy, new_param_hash, { user_id: @teacher.id }
      expect(QuestionSet.all.count).to eq(0)
    end

    it "cannot be deleted by a student" do
      expect {
        delete :destroy, {class_group_id: @class_group.id, id: @question_set.id}, { user_id: @student.id }
      }.to change(Question, :count).by(0)
    end

    it "cannot be deleted by a teacher of another class" do
      expect {
        delete :destroy, {class_group_id: @class_group.id, id: @question_set.id}, { user_id: @other_teacher.id }
      }.to change(Question, :count).by(0)
    end 
  end 
end
