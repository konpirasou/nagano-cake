class OrderProduct < ApplicationRecord

  belongs_to :order
  belongs_to :product

  def add_tax_price
    (self.price * 1.10).round
  end


end
