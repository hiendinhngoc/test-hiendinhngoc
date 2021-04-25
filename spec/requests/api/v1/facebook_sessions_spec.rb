# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::FacebookSessions', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/facebook_sessions/create'
      expect(response).to have_http_status(:success)
    end
  end
end