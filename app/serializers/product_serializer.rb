# app/serializers/product_serializer.rb
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :stock, :in_stock
end
