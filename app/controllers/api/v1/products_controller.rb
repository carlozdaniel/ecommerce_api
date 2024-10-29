# app/controllers/api/v1/products_controller.rb
class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user!, only:  %i[ create update destroy ]
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
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def update
    if product.update(product_params)
      render json: product, serializer: ProductSerializer
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if product.destroy
      render status: :ok
    end
  end

  private

  def product
    Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
    .merge(user: current_user)
  end
end
