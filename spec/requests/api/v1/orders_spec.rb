# spec/requests/api/v1/orders_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user, stock: 10) }
  let!(:order) { create(:order, user: user) }
  let!(:order_item) { create(:order_item, order: order, product: product, quantity: 2, price: product.price, subtotal: product.price * 2) }

  before do
    sign_in user
  end

  describe "GET /api/v1/orders" do
    it "returns a list of orders for the current user" do
      get api_v1_orders_path

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET /api/v1/orders/:id" do
    it "returns the specified order" do
      get api_v1_order_path(order)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(order.id)
    end

    it "returns 404 if the order does not belong to the user" do
      other_user = create(:user)
      other_order = create(:order, user: other_user)

      get api_v1_order_path(other_order)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/orders" do
    let(:order_params) do
      {
        order: {
          shipping_address: "123 Test Street",
          order_items_attributes: [
            { product_id: product.id, quantity: 2 }
          ]
        }
      }
    end

    it "creates a new order with valid attributes" do
      post api_v1_orders_path, params: order_params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["shipping_address"]).to eq("123 Test Street")
    end
  end

  describe "DELETE /api/v1/orders/:id" do
    it "deletes the specified order" do
      delete api_v1_order_path(order)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Order deleted successfully")
    end

    it "returns unprocessable_entity if deletion fails" do
      allow_any_instance_of(Order).to receive(:destroy).and_return(false)
      delete api_v1_order_path(order)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Failed to delete the order")
    end
  end

  describe "PATCH /api/v1/orders/:id/mark_as_paid" do
    it "marks the order as paid" do
      patch mark_as_paid_api_v1_order_path(order)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Order marked as paid successfully")
    end

    it "returns unprocessable_entity if marking as paid fails" do
      allow_any_instance_of(Order).to receive(:update).and_return(false)
      patch mark_as_paid_api_v1_order_path(order)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq("Failed to update order status")
    end
  end
end
