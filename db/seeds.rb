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

Product.create!(genre_id: 1, name: "test", introduction: "test", price: 1000, is_active: true, image: File.open("app/assets/images/cake-3555184_1920.jpg"))
Product.create!(genre_id: 1, name: "test2", introduction: "test2", price: 1000, is_active: true, image: File.open("app/assets/images/muffins-4002550_1920.jpg"))
Product.create!(genre_id: 2, name: "test3", introduction: "test3", price: 1000, is_active: true, image: File.open("app/assets/images/cheesecake-1578691_1920.jpg"))
Product.create!(genre_id: 2, name: "test4", introduction: "test4", price: 1000, is_active: true, image: File.open("app/assets/images/cake-4167209_1920.jpg"))
Product.create!(genre_id: 3, name: "test5", introduction: "test5", price: 1000, is_active: true, image: File.open("app/assets/images/strawberries-3285333_1920.jpg"))
Product.create!(genre_id: 3, name: "test6", introduction: "test6", price: 1000, is_active: true, image: File.open("app/assets/images/breakfast-2151201_1920.jpg"))
Product.create!(genre_id: 4, name: "test7", introduction: "test7", price: 1000, is_active: true, image: File.open("app/assets/images/cake-1869227_1920.jpg"))
Product.create!(genre_id: 4, name: "test8", introduction: "test8", price: 1000, is_active: true, image: File.open("app/assets/images/the-cake-427920_1920.jpg"))

CartProduct.create!(customer_id: 1, product_id: 1, amount: 1)

Order.create!(customer_id: 1, postal_code: "0000000", address: "東京都新宿区新宿", name: "新宿太郎", shipping_cost: 800, total_payment: 5000, payment_method: 0, status: 0 )
OrderProduct.create!(product_id: 1, order_id: 1, price: 2000, amount: 2, product_status: 0)
OrderProduct.create!(product_id: 2, order_id: 1, price: 3000, amount: 3, product_status: 0)

Order.create!(customer_id: 2, postal_code: "0000000", address: "東京都渋谷区渋谷", name: "渋谷次郎", shipping_cost: 800, total_payment: 5000, payment_method: 0, status: 0 )
OrderProduct.create!(product_id: 1, order_id: 2, price: 2000, amount: 2, product_status: 0)
OrderProduct.create!(product_id: 2, order_id: 2, price: 3000, amount: 3, product_status: 0)