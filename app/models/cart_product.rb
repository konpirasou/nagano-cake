class CartProduct < ApplicationRecord

  belongs_to :product
  belongs_to :customer

  def sum_of_price
    product.price * amount
  end


end
