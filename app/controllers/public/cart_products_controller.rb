class Public::CartProductsController < ApplicationController

  before_action :authenticate_customer!
  before_action :setup_cart_product!, only: [:create, :update, :destroy]

  def index
    @cart_products = current_cart.cart_products
  end

  def create
    if @cart_product.blank?
      @cart_product = current_cart.cart_products.build(product_id: params[:product_id])
    end

    @cart_product.amount += params[:amount].to_i
    @cart_product.save
    redirect_to current_cart
  end

  def update
    @cart_product.update(amount: params[:amount].to_i)
    redirect_to current_cart
  end

  def destroy
    @cart_product.destroy
    redirect_to current_cart
  end

  def destroy_all
    @cart_products = current_cart.cart_products
    @cart_products.destroy_all
    redirect_to cart_products_path, notice: "商品を全て削除しました。"
  end

  private

    def setup_cart_product!
      @cart_product = current_cart.cart_products.find_by(product_id: params[:product_id])
    end
end
