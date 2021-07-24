class Public::ProductsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_search]
      @products = Product.where(genre_id: params[:genre_search]).page(params[:page]).per(8)
    else
      @products = Product.all.page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
    @cart_product = CartProduct.new
    @comment = Comment.new
    if current_customer
      @comments = @product.comments.find_by(customer_id: current_customer.id)
    end
  end
end
