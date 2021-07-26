class Public::CartProductsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @cart_products = current_customer.cart_products
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += (cart_product.product.add_tax_price * cart_product.amount)
    end
  end

  def create
    if  cart_item = current_customer.cart_products.find_by(product_id: params[:cart_product][:product_id])
      cart_item.amount += params[:cart_product][:amount].to_i
      cart_item.save
      flash[:notice] = "アイテムの追加に成功しました。"
      redirect_to cart_products_path
    else
      @cart_product = current_customer.cart_products.new(cart_product_params)
      @cart_product.save
      flash[:notice] = "新しいアイテムが追加されました。"
      redirect_to cart_products_path
    end
  end

  def update
    @cart_product = CartProduct.find(params[:id])
    @cart_product.update(amount: params[:cart_product][:amount].to_i)
    # 非同期通信用 変数
    @cart_products = current_customer.cart_products
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += (cart_product.product.add_tax_price * cart_product.amount)
    end
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
    # 非同期通信用 変数
    @cart_products = current_customer.cart_products
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += (cart_product.product.add_tax_price * cart_product.amount)
    end
  end

  def destroy_all
    @cart_products = current_customer.cart_products
    @cart_products.destroy_all
    # 非同期通信用 変数
    @cart_products = current_customer.cart_products
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += (cart_product.product.add_tax_price * cart_product.amount)
    end
  end

  private

    def cart_product_params
      params.require(:cart_product).permit(:amount, :product_id)
    end

end