require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  
  before(:all) do
    catelyn = User.create([
      {
        provider: "github",
        uid: "9999999",
        name: "Catelyn Tully",
        nickname: "Cat",
        verified: false
      }])
    ed = User.create([
      {
        provider: "github",
        uid: "1111111",
        name: "Ed Stark",
        nickname: "Ned",
        verified: true
      }])
    cohort8 = ClassGroup.create([
      {
        name: "Cohort 8, The Ocho"
      }])
  end


  describe "GET show_cohort8" do
    it "returns http success" do
      get :show, :id => 1
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "Create" do
    it "allows verified accounts" do
      User.create(:verified => true)
      # Sign in the user
      post :create, :name => "My Class"
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
    it "does not allow unverified accounts" do
    end
  end

end