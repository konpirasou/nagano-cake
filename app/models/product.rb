class Product < ApplicationRecord

  has_many    :cart_products,	foreign_key: "product_id", dependent: :destroy
  has_many    :customer, through: :cart_products,	source: :customer
  has_many    :order_products, foreign_key: "product_id",	dependent: :destroy
  has_many    :order, through: :order_products,	source: :order
  belongs_to  :genre
  attachment :image

  def add_tax_price
      (self.price * 1.10).round
  end

  def self.search(model,keyword)
    if model == "products" && keyword
      where(["name like? OR introduction like?", "%#{keyword}%", "%#{keyword}%"])
    else
      all
    end
  end

end
