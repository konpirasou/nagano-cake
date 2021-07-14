class Order < ApplicationRecord

  belongs_to :customer
  has_many	 :order_products,	foreign_key: "product_id", dependent: :destroy
  has_many	 :products,	through: order_products, source: :product

end
