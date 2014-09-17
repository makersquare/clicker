require 'rails_helper'

RSpec.describe 'Teacher Flow' do

  before do
    @teacher = Fabricate(:verified_user)
  end

  let(:session) do
    { user_id: @teacher.id }
  end

  it 'directs them to the sign in page' do
    get '/'
    expect(response).to render_template(:index)
  end

  it 'allows them to sign in with github and directs them to the class page' do
    # get '/auth/github'
    # get_via_redirect '/auth/github'
    # expect(response).to render_template(:index)
    # session[:user_id] = @teacher.id
    # expect(response).to redirect_to('/auth/github/callback')
  end

  describe 'github' do
    it "should login with github", :js => true do
      get "/test_sign_in/#{@teacher.id}"
      get '/'
      expect(response).to redirect_to('/class_groups')
    end
  end

end
