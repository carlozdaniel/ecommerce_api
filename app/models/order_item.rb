class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  before_validation :assign_product
  after_save :reduce_product_stock
  after_destroy :restore_product_stock

  private

  def reduce_product_stock
    product.update(stock: product.stock - quantity)
  end

  def restore_product_stock
    product.update(stock: product.stock + quantity)
  end

  def assign_product
    self.product = Product.find_by(id: product_id) if product_id.present?
  end
end
