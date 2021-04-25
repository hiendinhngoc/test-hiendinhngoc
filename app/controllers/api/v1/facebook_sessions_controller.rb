# frozen_string_literal: true

module Api
  module V1
    class FacebookSessionsController < ApplicationController
      before_action :authenticate

      def create
        render json: facebook_token, status: :created
      end

      private

      def authenticate
        raise Knock.not_found_exception_class if entity.blank?
      end

      def facebook_token
        if entity.respond_to? :to_token_payload
          Knock::AuthToken.new payload: entity.to_token_payload
        else
          Knock::AuthToken.new payload: { sub: entity.id }
        end
      end

      def entity
        @entity ||=
          if AuthService.valid_token?(auth_params[:access_token])
            data = AuthService.user_data(auth_params[:access_token])
            User.find_or_create_by uid: data['id'] do |user|
              user.first_name = data['first_name']
              user.last_name = data['last_name']
              user.email = data['email']
            end
          end
      end

      def auth_params
        params.require(:auth).permit :access_token
      end
    end
  end
end
