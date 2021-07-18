class Public::CartProductsController < ApplicationController

  before_action :authenticate_customer!


  def index
    @products = current_customer.cart_products
    # @cart_products = current_customer.cart_products
  end

  def create


    @cart_product.amount += params[:amount].to_i
    @cart_product.save
    redirect_to cart_products_path
  end

  def update
    @cart_product = CartProduct.find(params[:id])
    @cart_product.update(amount: params[:cart_product][:amount].to_i)
    redirect_to cart_products_path
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



end