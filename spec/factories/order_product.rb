FactoryBot.define do
  factory :order_product do
    product_id { 1 } 
    order_id { 1 } 
    price { 2000 } 
    amount { 2 }
  end
end
