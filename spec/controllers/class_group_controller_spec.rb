require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  
  describe "GET show_cohort_8" do
    it "returns http success" do
      get :show_cohort_8
      expect(response).to be_success
    end
  end

  describe "Create" do
    it "allows verified accounts" do
      User.create(:verified => true)
      # Sign in the user
      post :create, :name => "My Class"
      expect(response).to be_success
    end
    
    it "does not allow unverified accounts" do
    end
  end

end