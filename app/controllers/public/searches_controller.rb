class Public::SearchesController < ApplicationController

  def search
    @genres = Genre.all
    @products_page = Product.page(params[:page]).per(10)
    if params[:model] == "products" && current_customer
      @products = Product.search(params[:model], params[:keyword]).page(params[:page]).per(8)
      @products_count = Product.search(params[:model], params[:keyword])
      render "public/products/index"
    elsif params[:model] == "products" && current_admin
      @products = Product.search(params[:model], params[:keyword]).page(params[:page]).per(8)
      @products_count = Product.search(params[:model], params[:keyword])
      render "admin/products/index"
    elsif params[:model] == "customers"
      @customers = Customer.search(params[:model], params[:keyword]).page(params[:page]).per(8)
      render "admin/customers/index"
    else
      @products = Product.search(params[:model], params[:keyword]).page(params[:page]).per(8)
      @products_count = Product.search(params[:model], params[:keyword])
      render "public/products/index"
    end
  end

end
