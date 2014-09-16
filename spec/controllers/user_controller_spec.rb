require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  render_views
  
  before do
    @student = Fabricate(:user)
    @teacher = Fabricate(:teacher)
  end

end