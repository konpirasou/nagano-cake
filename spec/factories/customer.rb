FactoryBot.define do
  factory :customer do
    last_name { "田中" }
    first_name { "太郎" }
    last_name_kana { "タナカ" }
    first_name_kana { "タロウ" }
    # email { "test1@mail.com" }
    sequence(:email) { |n| "test#{n}@mail.com" }
    password { "password" }
    postal_code { "0000000" }
    address { "東京都新宿区東新宿3-3" }
    telephone_number { "00000000" }
  end
end
