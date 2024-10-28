class Product < ApplicationRecord
  has_many :order_items

  before_save :update_in_stock_status

  private

  def update_in_stock_status
    self.in_stock = stock > 0
  end
end
