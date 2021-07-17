class Admin::ProductsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @products = Product.all
    @products_page = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product), notice: "新しい商品を追加しました！"
    else
      render "new"
    end
  end

  def edit
    @product = Product.find(params[:id])
    @genres = Genre.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_product_path(@product), notice: "商品を編集しました！"
    else
      render "edit"
    end
  end

  private

    def product_params
      params.require(:product).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
    end
end
