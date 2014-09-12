require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  
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
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, {id: @classgroup.id}, {user_id: @student.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
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
      post :create, {classgroup_id: @classgroup_id}
      expect(count).to eq(1)
    end
    
    # Pending: Need to add verification of User first (see Issue #50)
    xit "does not allow unverified accounts" do
      User.create(:verified => false)
      # Sign in the user
      count = ClassGroup.all.count
      post :create, {classgroup_id: @classgroup_id}
      expect(count).to eq(0)
    end
  end

end