class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @new_products = Product.order(created_at: :desc).limit(4)  #新着情報
    @products = Product.order("RANDOM()").limit(1)  #
    @ranking = OrderProduct.all.group(:product_id).sum(:product_id).sort_by{|key,value| value}.reverse.to_h.keys
  end

  def about

  end
end
