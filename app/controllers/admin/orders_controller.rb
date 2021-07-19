class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    if params[:order_sort]
      @orders = Order.where(customer_id: params[:order_sort])
    else
      @orders = Order.all
    end
    @order_page = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
    @total_price = 0
    @order_products.each do |order_product|
      @total_price += (order_product.product.add_tax_price * order_product.amount)
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
		redirect_to admin_order_path(@order), notice: "注文ステータスを変更しました！"
  end

  private

  	def order_params
  	  params.require(:order).permit(:status)
  	end

end
