module IntegrationSpecHelper
  def login_with_oauth(service = :github)
    get "/auth/#{service}"
  end
end