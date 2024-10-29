require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user, stock: 10) }
  let(:order) { create(:order, user: user) }

  describe "validations" do
    it "is valid with a product, order, quantity, price, and subtotal" do
      order_item = OrderItem.new(order: order, product: product, quantity: 2, price: product.price, subtotal: product.price * 2)
      expect(order_item).to be_valid
    end

    it "is invalid without a product" do
      order_item = OrderItem.new(order: order, quantity: 2, price: product.price, subtotal: product.price * 2)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:product]).to include("must exist")
    end

    it "is invalid without an order" do
      order_item = OrderItem.new(product: product, quantity: 2, price: product.price, subtotal: product.price * 2)
      expect(order_item).not_to be_valid
      expect(order_item.errors[:order]).to include("must exist")
    end
  end

  describe "callbacks" do
    it "reduces the product stock when created" do
      expect {
        OrderItem.create(order: order, product: product, quantity: 2, price: product.price, subtotal: product.price * 2)
      }.to change { product.reload.stock }.by(-2)
    end

    it "restores the product stock when destroyed" do
      order_item = OrderItem.create(order: order, product: product, quantity: 2, price: product.price, subtotal: product.price * 2)

      expect {
        order_item.destroy
      }.to change { product.reload.stock }.by(2)
    end
  end
end
