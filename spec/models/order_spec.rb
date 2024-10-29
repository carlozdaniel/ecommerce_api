# spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:order) { create(:order, user: user) }

  describe 'associations' do
    it 'belongs to user' do
      expect(order.user).to eq(user)
    end

    it 'has many order_items' do
      order_item1 = create(:order_item, order: order, product: product, quantity: 5)
      order_item2 = create(:order_item, order: order, product: product, quantity: 5)

      order.reload

      expect(order.order_items).to include(order_item1, order_item2)
    end
  end
end
