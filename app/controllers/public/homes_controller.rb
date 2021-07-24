class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @new_products = Product.order(created_at: :desc).limit(4)  #新着情報
    @products = Product.order("RANDOM()").limit(1)  #トップ画面
  end

  def about

  end
end
