require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  render_views

  before do
    @student = Fabricate(:user)
    @teacher = Fabricate(:verified_user)
    @class_group = Fabricate(:class_group)
    @class_group2 = Fabricate(:class_group)

    @class_group.memberships.create(
      user_id: @student.id,
      kind: "student"
    )
    @class_group.memberships.create(
      user_id: @teacher.id,
      kind: "teacher"
    )
  end

  describe "GET #show" do
    it "responds successfully with HTTP 200 status code for student" do
      get :show, {id: @class_group.id}, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('class_groups/show')
    end

    it "responds successfully with HTTP 200 status code for teacher" do
      get :show, {id: @class_group.id}, {user_id: @teacher.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('class_groups/show')
    end

    it "does not allow users that are not members of the class to view the class and redirects to index" do
      get :show, {id: @class_group2.id}, {user_id: @student.id}
      expect(response).to_not render_template(:show)
      expect(response).to redirect_to(class_groups_path)
    end
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, nil, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "allows verified accounts to create class groups" do
      expect{
        post :create, {class_group: {name: "Best Class", description: "really"}}, {user_id: @teacher.id}
      }.to change(ClassGroup, :count).by(1)
    end
    
    it "does not allow unverified accounts to create class groups" do
      expect{
        post :create, {class_group: {name: "Best Class", description: "really"}}, {user_id: @student.id}
      }.to change(ClassGroup, :count).by(0)
    end

    it "shows form errors" do
      
      original_count = ClassGroup.all.count
      post_params = {
        class_group_id: @class_group.id,
        class_group: {
          name: "",
          description: "The Ocho"
        }
      }
      post :create, post_params, { user_id: @teacher.id }

      expect(ClassGroup.all.count).to eq(original_count)
      expect(response).to render_template 'class_groups/index'
      expect(response.body).to include "error", ERB::Util.html_escape("title can't be blank")
    end
  end

end
