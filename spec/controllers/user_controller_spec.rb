require 'rails_helper'

RSpec.describe ClassGroupsController, :type => :controller do
  
  describe "GET users/1" do
    it "returns http success" do
      get "users/1"
      expect(response).to be_success
    end
  end 
    
  

end