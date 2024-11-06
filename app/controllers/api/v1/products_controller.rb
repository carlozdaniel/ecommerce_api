# app/controllers/api/v1/products_controller.rb
class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user_or_doorkeeper!
  def index
    render json: Product.all, each_serializer: ProductSerializer
  end

  def show
    render json: product, serializer: ProductSerializer
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, serializer: ProductSerializer, status: :created

    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if product.update(product_params)
      render json: product, serializer: ProductSerializer
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if product.destroy
      render json: { message: "Product deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete product" }, status: :unprocessable_entity
    end
  end

  def most_sold
    most_sold_products = Product.most_sold
    render json: most_sold_products, each_serializer: ProductSerializer
  end

  private

  def product
    @product ||= Product.find(params[:id])
  end

  def product_params
    permitted_params = params.require(:product).permit(:name, :description, :price, :stock)
    permitted_params[:user] = current_user if current_user.present?
    permitted_params
  end
end
