class Product < ApplicationRecord

  has_many  :cart_products,	foreign_key: "product_id", dependent: :destroy
  has_many  :customer, through: :cart_products,	source: :customer
  has_many  :order_products, foreign_key: "product_id",	dependent: :destroy
  has_many  :order, through: :order_products,	source: :order
  has_many  :comments, dependent: :destroy
  has_many  :favorites, dependent: :destroy
  belongs_to  :genre
  attachment :image

  def self.review_persent(star,comment)
    case star
    when 5
      (self.where("rate = 5").count.to_f / self.pluck(:rate).count.to_f * 100).to_i
    when 4
      (self.where("rate = 4").count.to_f / self.pluck(:rate).count.to_f * 100).to_i
    when 3
      (self.where("rate = 3").count.to_f / self.pluck(:rate).count.to_f * 100).to_i
    when 2
      (self.where("rate = 2").count.to_f / self.pluck(:rate).count.to_f * 100).to_i
    when 1
      (self.where("rate = 1").count.to_f / self.pluck(:rate).count.to_f * 100).to_i
    end
  end

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

  def self.all_month(product)
    jan = Date.today.beginning_of_year
    feb = Date.today.beginning_of_year.next_month(1)
    mar = Date.today.beginning_of_year.next_month(2)
    apr = Date.today.beginning_of_year.next_month(3)
    may = Date.today.beginning_of_year.next_month(4)
    jun = Date.today.beginning_of_year.next_month(5)
    jul = Date.today.beginning_of_year.next_month(6)
    aug = Date.today.beginning_of_year.next_month(7)
    sep = Date.today.beginning_of_year.next_month(8)
    oct = Date.today.beginning_of_year.next_month(9)
    nov = Date.today.beginning_of_year.next_month(10)
    dec = Date.today.beginning_of_year.next_month(11)

    data = {"#{jan.month}月" => product.order_products.where(created_at: jan..feb).sum(:amount),#1月
      "#{feb.month}月" => product.order_products.where(created_at: feb..mar).sum(:amount),#2月
      "#{mar.month}月" => product.order_products.where(created_at: mar..apr).sum(:amount),#3月
      "#{apr.month}月" => product.order_products.where(created_at: apr..may).sum(:amount),#4月
      "#{may.month}月" => product.order_products.where(created_at: may..jun).sum(:amount),#5月
      "#{jun.month}月" => product.order_products.where(created_at: jun..jul).sum(:amount),#6月
      "#{jul.month}月" => product.order_products.where(created_at: jul..aug).sum(:amount),#7月
      "#{aug.month}月" => product.order_products.where(created_at: aug..sep).sum(:amount),#8月
      "#{sep.month}月" => product.order_products.where(created_at: sep..oct).sum(:amount),#9月
      "#{oct.month}月" => product.order_products.where(created_at: oct..nov).sum(:amount),#10月
      "#{nov.month}月" => product.order_products.where(created_at: nov..dec).sum(:amount),#11月
      "#{dec.month}月" => product.order_products.where(created_at: dec..dec.end_of_month).sum(:amount)#12月
    }
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
