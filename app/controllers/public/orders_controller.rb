class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
  end

  def complete
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order = Order.find(params[:id])
    @total_price = 0
    @order.order_products.each do |product|
      @total_price += (product.add_tax_price * product.amount)
    end
  end
end
