FactoryBot.define do
  factory :order do
    customer_id { 1 }
    postal_code  {"0000000" }
    address { "東京都新宿区東新宿3-3" }
    name { "田中太郎" }
    shipping_cost { 800 }
    total_payment { 3000 }
  end
end
