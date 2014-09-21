# Be sure to restart your server when you modify this file.

unless Rails.env.test?
  Rails.application.config.session_store :cookie_store, key: '_clicker_session', domain: '.clicker.dev'
end
