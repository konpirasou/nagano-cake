FactoryBot.define do
  factory :product do
    genre_id { 1 }
    sequence(:name) { |n| "test#{n}" }
    sequence(:introduction) { |n| "test#{n}" }
    price { "1,000" }
    image { File.open("app/assets/images/eclair-3366430_640.jpg") }
  end
end
