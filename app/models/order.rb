class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items

  belongs_to :user

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = order_items.sum { |item| item.subtotal }
  end
end
