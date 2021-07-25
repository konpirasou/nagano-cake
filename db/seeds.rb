# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: "admin@mail.com", password: "password", password_confirmation: "password")

Customer.create!(email:"test1@mail.com",password:"password",last_name:"太郎",first_name:"山田",last_name_kana:"タロウ",first_name_kana:"ヤマダ",postal_code:"0000000",address:"東京",telephone_number:"00000000")
Customer.create!(email:"test2@mail.com",password:"password",last_name:"花子",first_name:"佐藤",last_name_kana:"ハナコ",first_name_kana:"サトウ",postal_code:"0000000",address:"東京",telephone_number:"00000000")
Customer.create!(email:"test3@mail.com",password:"password",last_name:"あああ",first_name:"いいい",last_name_kana:"アアア",first_name_kana:"イイイ",postal_code:"0000000",address:"東京",telephone_number:"00000000")

Genre.create!(name: "ケーキ")
Genre.create!(name: "プリン")
Genre.create!(name: "焼き菓子")
Genre.create!(name: "キャンディ")

Product.create!(genre_id: 1, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/cheesecake-2598695_1280.jpg"))
Product.create!(genre_id: 1, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/coffee-3163596_1280.jpg"))
Product.create!(genre_id: 2, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/muffins-4002553_1280.jpg"))
Product.create!(genre_id: 2, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/cheesecake-2598695_1280.jpg"))
Product.create!(genre_id: 3, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/dessert-3331009_1280.jpg"))
Product.create!(genre_id: 3, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/blueberry-1082500_1280.jpg"))
Product.create!(genre_id: 4, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/breakfast-2151201_1280.jpg"))
Product.create!(genre_id: 4, name: Faker::Dessert.variety, introduction: Faker::Lorem.sentences(number: 30), price: 1000, is_active: true, image: File.open("app/assets/images/coffee-3163596_1280.jpg"))

CartProduct.create!(customer_id: 1, product_id: 1, amount: 1)

Order.create!(customer_id: 1, postal_code: "0000000", address: "東京都新宿区新宿", name: "新宿太郎", shipping_cost: 800, total_payment: 5000, payment_method: 0, status: 0 )
OrderProduct.create!(product_id: 1, order_id: 1, price: 2000, amount: 2, product_status: 0)
OrderProduct.create!(product_id: 2, order_id: 1, price: 3000, amount: 3, product_status: 0)

Order.create!(customer_id: 2, postal_code: "0000000", address: "東京都渋谷区渋谷", name: "渋谷次郎", shipping_cost: 800, total_payment: 5000, payment_method: 0, status: 0 )
OrderProduct.create!(product_id: 1, order_id: 2, price: 2000, amount: 2, product_status: 0)
OrderProduct.create!(product_id: 2, order_id: 2, price: 3000, amount: 3, product_status: 0)