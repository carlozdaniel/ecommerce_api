# spec/requests/api/v1/products_spec.rb
require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let(:application) { create(:oauth_application) }
  let(:token) { create(:access_token, application: application) }
  let(:product) { create(:product) }

  describe 'GET /api/v1/products' do
    context 'with valid access token' do
      it 'returns all products' do
        create_list(:product, 5)
        get '/api/v1/products', headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end

    context 'without access token' do
      it 'returns an unauthorized response' do
        get '/api/v1/products'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with expired access token' do
      it 'returns an unauthorized response' do
        expired_token = create(:access_token, application: application, expires_in: -1.hour)
        get '/api/v1/products', headers: { Authorization: "Bearer #{expired_token.token}" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/products/:id' do
    context 'with valid access token' do
      it 'returns a specific product' do
        get "/api/v1/products/#{product.id}", headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['id']).to eq(product.id)
      end
    end
  end

  describe 'POST /api/v1/products' do
    context 'with valid access token' do
      it 'creates a new product' do
        product_params = { product: { name: 'New Product', description: 'Test product', price: 100.0, stock: 20 } }
        post '/api/v1/products', params: product_params, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('New Product')
      end
    end
  end

  describe 'PUT /api/v1/products/:id' do
    context 'with valid access token' do
      it 'updates the product' do
        put "/api/v1/products/#{product.id}", params: { product: { name: 'Updated Product' } }, headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:success)
        expect(product.reload.name).to eq('Updated Product')
      end
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    context 'with valid access token' do
      it 'deletes the product' do
        delete "/api/v1/products/#{product.id}", headers: { Authorization: "Bearer #{token.token}" }
        expect(response).to have_http_status(:ok)
        expect(Product.find_by(id: product.id)).to be_nil
      end
    end
  end
end
