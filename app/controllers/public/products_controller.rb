class Public::ProductsController < ApplicationController
  def index
    @genres = Genre.all
    @products = Product.all.page(params[:page]).per(8)
  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
  end
end
