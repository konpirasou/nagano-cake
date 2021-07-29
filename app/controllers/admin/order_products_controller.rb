class Admin::OrderProductsController < ApplicationController

  before_action :authenticate_admin!

  def update
    order_products = OrderProduct.find(params[:id])
    order_products.update(order_product_params)
    if order_products.product_status == "製作中"
      order_products.order.update(status: 2)
    elsif order_products.order.order_products.where(product_status: "製作完了").count == order_products.order.order_products.count
      order_products.order.update(status: 3)
    end
		redirect_to admin_order_path(order_products.order), notice: "制作ステータスを変更しました！"
  end

  private

  def order_product_params
    params.require(:order_product).permit(:product_status)
  end

end
