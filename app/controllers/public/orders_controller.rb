class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_select] == "1"
      @order_address = Address.find(params[:customer_id])
      @order.postal_code = @order_address.postal_code
      @order.address     = @order_address.address
      @order.name        = @order_address.name
    end
    # @order = current_customer.orders
    # @order_product = @order.order_products
    @cart_products = current_customer.cart_products
    @total_price = 0
    @cart_products.each do |cart_product|
      @total_price += (cart_product.product.add_tax_price * cart_product.amount)
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
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

  private

    def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method, :total_price)
    end

end
