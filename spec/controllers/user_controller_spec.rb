require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  
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
  end
  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
        get :show, nil, {user_id: @student.id}
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
  end 
    
  

end