require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  render_views

  before do
    @student = User.create(
      provider: "github",
      uid: "9999999",
      name: "Catelyn Tully",
      nickname: "Cat",
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
    @class_group = ClassGroup.create(
      name: "Cohort 8, The Ocho",
      description: "MKS immersive course"
    )

    @classgroup2 = ClassGroup.create(
      name: "Cohort 9",
      description: "the newbies"
    )

    Membership.create(
      user_id: 1,
      class_group_id: 1,
      kind: "student"
    )
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, {id: @class_group.id}, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "does not allow users that are not members of the class to view the class" do
      get :show, {id: @classgroup2.id}, {user_id: @student.id}
      #expect(response).to be_success
      expect(response).to have_http_status(302)      
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
    it "allows verified accounts" do
      User.create(:verified => true)
      # Sign in the user
      count = ClassGroup.all.count
      post :create, {class_group_id: @class_group.id}
      expect(count).to eq(1)
    end
    
    # Pending: Need to add verification of User first (see Issue #50)
    xit "does not allow unverified accounts" do
      User.create(:verified => false)
      # Sign in the user
      count = ClassGroup.all.count
      post :create, {class_group_id: @class_group.id}
      expect(count).to eq(0)
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
      expect(response.body).to include "error", ERB::Util.html_escape("Name can't be blank")
    end
  end

end
