class Public::CartProductsController < ApplicationController

  before_action :authenticate_customer!
  before_action :setup_cart_product!, only: [:create]

  def index
    @cart_products = current_customer.cart_products
  end

  def create
    if @cart_product.blank?
      # @cart_product = current_customer.cart_products.new(cart_product_params)
      @cart_product = current_customer.cart_products.build(product_id: params[:cart_product][:product_id])
    else
      @cart_product.amount += params[:cart_product][:amount].to_i
    end

    @cart_product.save
    # binding.pry
    redirect_to cart_products_path
  end

  def update
    @cart_product = CartProduct.find(params[:id])
    @cart_product.update(amount: params[:cart_product][:amount].to_i)
    redirect_to cart_products_path
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    redirect_to cart_products_path
  end

  def destroy_all
    @cart_products = current_customer.cart_products
    @cart_products.destroy_all
    redirect_to cart_products_path, notice: "商品を全て削除しました。"
  end

  private

    def cart_product_params
      params.require(:cart_product).permit(:amount, :product_id)
    end

    def setup_cart_product!
      @cart_product = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
    end
end