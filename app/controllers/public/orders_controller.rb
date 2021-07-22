class Public::OrdersController < ApplicationController
  require "payjp"

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @total_price = 0
    @order.order_products.each do |product|
      @total_price += (product.product.add_tax_price * product.amount)
    end
  end

  def new
    if current_customer.cart_products.present?
      @order = Order.new
      @addresses = current_customer.addresses
    else
      redirect_to cart_products_path, notice: "カート内に商品がありません。"
    end

  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:payment] == "0"
      @order.payment_method = 0
    elsif params[:order][:payment] == "1"
      @order.payment_method = 1
    end

    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.first_name}#{current_customer.last_name}"
    elsif params[:order][:address_select] == "1"
      address = Address.find(params[:order][:address_selected].to_i)
      @order.address = address.address
      @order.name = address.name
      @order.postal_code = address.postal_code
    elsif params[:order][:address_select] == "2"
    end

    @order.shipping_cost = 800
    @order.customer_id = current_customer.id
    @cart_products = current_customer.cart_products
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += (cart_product.product.add_tax_price * cart_product.amount)
    end
    @order.total_payment = (@total_price + @order.shipping_cost)

  end

  def create
    order = Order.new(order_params)
    order.save
    current_customer.cart_products.each do |product|
      OrderProduct.create(product_id: product.product_id, order_id: order.id, price: (product.product.price * product.amount), amount: product.amount)
    end

    if order.payment_method == "クレジットカード"
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      pay = Payjp::Charge.create(
      amount: params[:order][:total_payment], # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
      )
    end

    if order.save == true
      current_customer.cart_products.destroy_all
      redirect_to orders_complete_path
    end

  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name , :shipping_cost, :total_payment, :payment_method)
  end

end
