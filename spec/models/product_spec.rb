# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { create(:user) }
  let(:product) { create(:product, stock: 10, user: user) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items) }
  end

  describe 'callbacks' do
    it 'sets in_stock to true if stock is positive' do
      product.stock = 5
      product.save
      expect(product.in_stock).to be true
    end

    it 'sets in_stock to false if stock is zero' do
      product.stock = 0
      product.save
      expect(product.in_stock).to be false
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
  end
end
