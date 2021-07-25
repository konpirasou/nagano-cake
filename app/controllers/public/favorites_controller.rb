class Public::FavoritesController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    favorite = current_customer.favorites.new(product_id: product.id)
    favorite.save
    redirect_to product_path(product)
  end

  def destroy
    product = Product.find(params[:product_id])
    favorite = current_customer.favorites.find_by(product_id: product.id)
    favorite.destroy
    redirect_to product_path(product)
  end
end
