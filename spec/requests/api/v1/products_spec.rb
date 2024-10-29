# spec/requests/api/v1/products_spec.rb
require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }

  before { sign_in user } # Autentica al usuario antes de cada prueba

  describe 'GET /api/v1/products' do
    it 'returns all products' do
      create_list(:product, 5, user: user)
      get '/api/v1/products'
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(5)
    end
  end

  describe 'GET /api/v1/products/:id' do
    it 'returns a specific product' do
      get "/api/v1/products/#{product.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['id']).to eq(product.id)
    end
  end

  describe 'POST /api/v1/products' do
    it 'creates a new product' do
      product_params = { product: { name: 'New Product', description: 'Test product', price: 100.0, stock: 20 } }
      post '/api/v1/products', params: product_params
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('New Product')
    end
  end

  describe 'PUT /api/v1/products/:id' do
    it 'updates the product' do
      put "/api/v1/products/#{product.id}", params: { product: { name: 'Updated Product' } }
      expect(response).to have_http_status(:success)
      expect(product.reload.name).to eq('Updated Product')
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    it 'deletes the product' do
      delete "/api/v1/products/#{product.id}"
      expect(response).to have_http_status(:ok)
      expect(Product.find_by(id: product.id)).to be_nil
    end
  end
end
