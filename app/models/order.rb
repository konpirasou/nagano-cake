class Order < ApplicationRecord

  belongs_to :customer
  has_many	 :order_products,	foreign_key: "order_id", dependent: :destroy
  has_many	 :products,	through: :order_products, source: :product

  enum statuses: { 0 => "着手不可", 1 => "制作待ち", 2 => "製作中", 3 => "制作完了" }, _prefix: true
  enum payment_methods: { 0 => "クレジットカード", 1 => "銀行振込" }, _prefix: true

end
