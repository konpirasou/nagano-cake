class Product < ApplicationRecord

  has_many    :cart_products,	foreign_key: "product_id", dependent: :destroy
  has_many    :customer, through: :cart_products,	source: :customer
  has_many    :order_products, foreign_key: "product_id",	dependent: :destroy
  has_many    :order, through: :order_products,	source: :order
  belongs_to  :genre
  attachment :image
end
