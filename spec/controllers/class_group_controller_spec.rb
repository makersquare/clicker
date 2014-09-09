require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  
  describe "GET show_cohort_8" do
    it "returns http success" do
      get :show_cohort_8
      expect(response).to be_success
    end
  end 

    
  

end