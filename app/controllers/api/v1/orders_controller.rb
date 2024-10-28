class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [ :show, :destroy ]

  def index
    render json: Order.all, each_serializer: OrderSerializer, status: :ok
  end

  def show
    render json: order, serializer: OrderSerializer, status: :ok
  end

  def create
    order = Order.build(order_params)
    if order.save
      render json: order, serializer: OrderSerializer, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.destroy
      render json: { message: "Order deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete the order" }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:shipping_address, order_items_attributes: %i[product_id quantity price])
  end
end
