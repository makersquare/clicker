require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  render_views
  
  before do
    @student = User.create(
      provider: "github",
      uid: "9999999",
      name: "Catelyn Tully",
      nickname: "Cat",
      verified: false,
      gravatar_id: "a4af3797c372cf36817f6767cefccc98"
    )
    @teacher = User.create(
      provider: "github",
      uid: "1111111",
      name: "Ed Stark",
      nickname: "Ned",
      verified: true,
      gravatar_id: "687058c0dcf54250a1dfef3515bbc2a7"
    )
  end

end