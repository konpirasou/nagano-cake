class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many	:addresses, dependent: :destroy
  has_many	:orders, dependent: :destroy
  has_many	:cart_products, foreign_key: "customer_id",	dependent: :destroy
  has_many	:products, through: :cart_products,	source: :product

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  # validates :is_deleted, presence: true

  paginates_per 10

  def self.search(model,keyword)
    if model == "customers" && keyword
      where(["last_name like? OR first_name like? OR email like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    else
      all
    end
  end

  # is_deleted==trueの場合、ログインさせない
  def active_for_authentication?
    super && !(is_deleted?)
  end

  def inactive_message
    "既に退会済みです"
  end

end
