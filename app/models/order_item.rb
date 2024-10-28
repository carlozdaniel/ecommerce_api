class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_save :calculate_subtotal
  after_save :reduce_product_stock
  after_destroy :restore_product_stock

  private

  def calculate_subtotal
    self.subtotal = price * quantity
  end

  def reduce_product_stock
    product.update(stock: product.stock - quantity)
  end

  def restore_product_stock
    product.update(stock: product.stock + quantity)
  end
end
