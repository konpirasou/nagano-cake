class Admin::OrderProductsController < ApplicationController

  before_action :authenticate_admin!

  def update
    order_products = OrderProduct.find(params[:id])
    order_products.update(order_product_params)
		redirect_to admin_order_path(order_products.order), notice: "制作ステータスを変更しました！"
  end

  private

	
  	def order_product_params
  	  params.require(:order_product).permit(:product_status)
  	end
  	
end
