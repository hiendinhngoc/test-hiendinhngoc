# frozen_string_literal: true

class AuthService
  def self.valid_token?(access_token)
    valid = false

    begin
      token = Koala::Facebook::API.new(access_token)
                                  .debug_token(app_access_token_info['access_token'])
      valid = true if token['data']['is_valid']
    ensure
      valid
    end
  end

  def self.user_data(access_token)
    return unless valid_token?(access_token)

    Koala::Facebook::API.new(access_token)
                        .get_object('me', fields: 'name,first_name,last_name,email')
  end

  def self.app_access_token_info
    @app_access_token_info ||= Koala::Facebook::OAuth.new.get_app_access_token_info
  end
end
