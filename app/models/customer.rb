class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many	:addresses, dependent: :destroy
  has_many	:orders, dependent: :destroy
  has_many	:cart_products, foreign_key: "customer_id",	dependent: :destroy
  has_many	:products, through: :cart_products,	source: :product

  paginates_per 10

end
