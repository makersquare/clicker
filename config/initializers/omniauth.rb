# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
	# GITHUB_CONFIG = YAML.load_file("#{::Rails.root}/config/_github.yml")[::Rails.env]

  # If you choose to use ENV variables with "config/application.yml" file with figaro,
  # you can use the following format:
  provider :github, ENV['GITHUB_ID'], ENV['GITHUB_SECRET'], scope: "user:email,user:follow"

  # If using "config/_github.yml", use the following declaration with the the YAML load file call above:
  # provider :github, GITHUB_CONFIG['app_id'], GITHUB_CONFIG['secret'], scope: "user:email,user:follow"
end
