class Order < ApplicationRecord
  attr_reader :error_message

  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items
  validate :validate_stock_availability, on: :create

  belongs_to :user

  before_save :calculate_total_price

  private

  def validate_stock_availability
    order_items.each do |item|
      product = item.product
      if product.stock < item.quantity
        errors.add(:base, "Insufficient stock for #{product.name}")
      end
    end
  end

  def calculate_total_price
    self.total_price = order_items.sum { |item| item.subtotal }
  end
end
