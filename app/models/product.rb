# app/models/product.rb
class Product < ApplicationRecord
  has_many :order_items
  belongs_to :user

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_save :update_in_stock_status

  # Método para obtener los productos más vendidos (recomendación sencilla)
  def self.most_sold(limit = 5)
    joins(:order_items)
      .group("products.id")
      .order("COUNT(order_items.id) DESC")
      .limit(limit)
  end

  private

  def update_in_stock_status
    self.in_stock = stock > 0
  end
end
