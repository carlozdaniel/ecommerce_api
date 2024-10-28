class OrderSerializer < ActiveModel::Serializer
  attributes :id, :total_price, :status, :shipping_address, :payment_status

  has_many :order_items, serializer: OrderItemSerializer
end
