class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!

  def index
    if params[:order_sort]
      @orders = Order.where(customer_id: params[:order_sort]).order(created_at: "DESC").page(params[:page]).per(10)
    else
      @orders = Order.all.order(created_at: "DESC").page(params[:page]).per(10)
    end
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
    @order.order_products.update(product_status: 1) if  @order.status == "入金確認"
		redirect_to admin_order_path(@order), notice: "注文ステータスを変更しました！"
  end


  private

	def order_params
	  params.require(:order).permit(:status)
	end

end
