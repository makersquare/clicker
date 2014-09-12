require 'spec_helper'
require 'rails_helper'
 
describe SessionsController do
 
  before do
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new({
      :provider => 'github',
      :uid => '123545',
      :info => {
                :name => "Randy Davis",
                :nickname => "Rand" 
      }
    })
  end
 
  describe "#create" do
 
    it "should successfully create a user" do
      post :create, provider: :github
      expect(User.count).to eq(1)
    end
 
    it "should successfully create a session" do
      expect(session[:user_id]).to be_nil 
      post :create, provider: :github
      expect(session[:user_id]).to_not be_nil
    end
 
    it "should redirect the user to the root url" do
      post :create, provider: :github
      expect(response).to redirect_to(root_url)
    end
 
  end
 
  describe "#destroy" do
    before do
      post :create, provider: :github
    end
 
    it "should clear the session" do
      expect(session[:user_id]).to_not be_nil
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
 
    it "should redirect to the home page" do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end
  end
 
end