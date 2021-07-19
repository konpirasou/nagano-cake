class OrderProduct < ApplicationRecord

  belongs_to :order
  belongs_to :product

  def add_tax_price
    (self.price * 1.10).round
  end

  enum  product_status: {"着手不可": 0, "制作待ち": 1, "制作中": 2, "制作完了": 3}

end
