class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.all, each_serializer: ProductSerializer
  end

  def show
    render json: product, serializer: ProductSerializer
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, serializer: ProductSerializer
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
  end
end
