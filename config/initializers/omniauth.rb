# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
	GITHUB_CONFIG = YAML.load_file("#{::Rails.root}/config/_github.yml")[::Rails.env]

  # If you choose to use ENV variables, you can use the following format:
  # provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user:email,user:follow"
  provider :github, GITHUB_CONFIG['app_id'], GITHUB_CONFIG['secret'], scope: "user:email,user:follow"
end
