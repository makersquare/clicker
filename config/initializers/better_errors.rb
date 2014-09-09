# Vagrant fix
if defined?(BetterErrors) && Rails.env.development?
  BetterErrors::Middleware.allow_ip! "10.10.10.1"
end