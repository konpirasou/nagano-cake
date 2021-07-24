class Public::CommentsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    comment = current_customer.comments.new(comment_params)
    comment.product_id = product.id
    if comment.save
      redirect_to product_path(product)
    else
      redirect_to product_path(product),alert:"コメントの投稿に失敗しました"
    end
  end

  def destroy
    Comment.find_by(id: params[:id], product_id: params[:product_id]).destroy
    redirect_to product_path(params[:product_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :comment, :rate)
  end
end
