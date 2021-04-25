# frozen_string_literal: true

Koala.configure do |config|
  # config.access_token = Rails.application.credentials.facebook[:access_token]
  # config.app_access_token = MY_APP_ACCESS_TOKEN
  config.app_id = Rails.application.credentials.facebook[:app_id]
  config.app_secret = Rails.application.credentials.facebook[:secret_key]
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end
