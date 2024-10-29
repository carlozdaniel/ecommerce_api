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

    order.order_items.each do |item|
      product = Product.find(item.product_id)
      if product.stock < item.quantity
        render json: { error: "Insufficient stock for #{product.name}" }, status: :unprocessable_entity and return
      end
      product.update(stock: product.stock - item.quantity)
      item.price = product.price
      item.subtotal = item.price * item.quantity
    end

    if order.save
      render json: order, serializer: OrderSerializer, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
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

  def order_params
    params.require(:order).permit(:shipping_address, order_items_attributes: %i[product_id quantity price])
  end
end
