require 'rails_helper'


RSpec.describe "student flow" do
  
  before do
    @student = Fabricate(:user, class_groups: [
      Fabricate(:class_group), 
      Fabricate(:class_group)
    ])

  end
  context 'when user is not signed in' do
    it 'allows a student to sign in with github and redirects to their list of classes' do
      get "/"
      expect(response).to render_template("welcome/index")
      OmniAuth.config.add_mock(:github, {:uid => @student.uid})
      click_button "Sign in with Github"
      binding.pry
      get "/"
      expect(response).to render_template("class_groups/index")
      
      #allow(response).to receive(:create).and_return(session[:user_id] = @student.id)
      # expect().to receive().with()
      # expect(response).to redirect_to(class_groups_path)
    end
  end

  context 'when user is previously signed in' do
    it 'redirects signed in student to their list of classes' do
      session = {user_id: @student.uid}
      OmniAuth.config.add_mock(:github, {:uid => @student.uid})
      get "/"
      binding.pry
      expect(response).to render_template("class_groups/index")

    end
  end

end