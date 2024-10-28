require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => "Bearer #{user_jwt_token}" } }

  def user_jwt_token
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
  end

  describe 'GET /api/v1/products' do
    it 'returns unauthorized without a valid token' do
      get '/api/v1/products'
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns products with a valid token' do
      get '/api/v1/products', headers: headers
      expect(response).to have_http_status(:ok)
    end
  end
end
