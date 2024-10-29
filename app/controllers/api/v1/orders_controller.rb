class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :order, only: %i[ show destroy mark_as_paid ]

  def index
    render json: current_user.orders.all, each_serializer: OrderSerializer, status: :ok
  end

  def show
    render json: order, serializer: OrderSerializer, status: :ok
  end

  def create
    order = current_user.orders.build(order_params)

    if order.save
      render json: order, serializer: OrderSerializer, status: :created
    else
      render json: { error: order.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    if order.destroy
      render json: { message: "Order deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete the order" }, status: :unprocessable_entity
    end
  end

  def mark_as_paid
    if order.update(status: "paid", payment_status: "paid")
      render json: { message: "Order marked as paid successfully" }, status: :ok
    else
      render json: { error: "Failed to update order status" }, status: :unprocessable_entity
    end
  end

  private

  def order
    current_user.orders.find(params[:id])
  end

  def product(id)
    Product.find_by(id: id)
  end

  def assign_product_item
    params[:order][:order_items_attributes].each do |item|
      found_product = product(item[:product_id])
      if found_product
        item[:price] = found_product.price
        item[:subtotal] = found_product.price * item[:quantity]
      end
    end
  end

  def order_params
    assign_product_item
    params.require(:order).permit(:shipping_address, order_items_attributes: %i[id product_id quantity price subtotal])
    .merge(user: current_user)
  end
end
