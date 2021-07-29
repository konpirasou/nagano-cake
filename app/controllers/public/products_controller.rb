class Public::ProductsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:genre_search]
      @products = Product.where(genre_id: params[:genre_search]).page(params[:page]).per(8)
      @products_count = Product.where(genre_id: params[:genre_search])
    elsif params[:fav_list]
      @products = current_customer.fav_products.page(params[:page]).per(8)
      @products_count = current_customer.fav_products
    else
      @products = Product.all.page(params[:page]).per(8)
      @products_count = Product.all
    end
    # ランキング機能
    @ranking = OrderProduct.all.group(:product_id).sum(:amount).sort_by{|key,value| value}.reverse.to_h.keys

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
