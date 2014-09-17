require 'rails_helper'


RSpec.describe "student flow" do
  
  before do
    @student = Fabricate(:user, class_groups: [
      Fabricate(:class_group, question_sets: [
        Fabricate(:question_set)
      ]), 
      Fabricate(:class_group)
    ])
  end

  let(:session) do
    { user_id: @student.id }
  end  

  it 'directs them to the sign in page' do
    get '/'
    expect(response).to render_template(:index)
  end

  describe 'github' do
    it "should login with github", :js => true do
      get "/test_sign_in/#{@student.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
    end
  end

  context 'when user is not signed in' do
    it 'allows a student to sign in with github and redirects to their list of classes' do
      get "/"
      expect(response).to render_template("welcome/index")
      #signs in
      get "/test_sign_in/#{@student.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
      
      #allow(response).to receive(:create).and_return(session[:user_id] = @student.id)
      # expect().to receive().with()
      # expect(response).to redirect_to(class_groups_path)
    end
  end

  context 'when user is previously signed in' do
    xit 'redirects signed in student to their list of classes' do
      session = {user_id: @student.uid}
      OmniAuth.config.add_mock(:github, {:uid => @student.uid})
      get "/"
      binding.pry
      expect(response).to render_template("class_groups/index")

    end
  end

end