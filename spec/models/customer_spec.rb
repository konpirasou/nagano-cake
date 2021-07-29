require 'rails_helper'

RSpec.describe Customer, type: :model do

  #姓、名、姓（カナ）、名（カナ）、メールアドレス、パスワード、住所、郵便番号、電話番号があれば有効な状態であること
  # it "is valid with a first_name, last_name, first_name_kana, last_name_kana, email, password, address, postal_code, and telephone_number" do

    # customer = Customer.new(
    #   email:"test1@mail.com",
    #   password:"password",
    #   last_name:"山田",
    #   first_name:"太郎",
    #   last_name_kana:"ヤマダ",
    #   first_name_kana:"タロウ",
    #   postal_code:"0000000",
    #   address:"東京",
    #   telephone_number:"00000000"
    # )

  #   expect(FactoryBot.build(:customer)).to be_valid

  # end

  #有効なファクトリを持つこと
  it "has a valid factory" do

    expect(FactoryBot.build(:customer)).to be_valid

  end
  #名がなければ無効な状態であること
  it "is invalid without a first_name" do

    # customer = Customer.new(first_name: nil)
    #spec/factories/customer.rb内の:customerから呼び出し
    customer = FactoryBot.build(:customer, first_name: nil)

    customer.valid?

    expect(customer.errors[:first_name]).to include("can't be blank")

  end
  #姓がなければ無効な状態であること
  it "is invalid without a last_name" do

    # customer = Customer.new(last_name: nil)
    customer = FactoryBot.build(:customer, last_name: nil)

    customer.valid?

    expect(customer.errors[:last_name]).to include("can't be blank")

  end
  #メールアドレスがなければ無効な状態であること
  it "is invalid without an email" do

    # customer = Customer.new(email: nil)
    customer = FactoryBot.build(:customer, email: nil)

    customer.valid?

    expect(customer.errors[:email]).to include("can't be blank")

  end
  #重複したメールアドレスなら無効な無効な状態であること
  it "is invalid with a duplicate email" do

    # Customer.create(
    #   email:"test1@mail.com",
    #   password:"password",
    #   last_name:"山田",
    #   first_name:"太郎",
    #   last_name_kana:"ヤマダ",
    #   first_name_kana:"タロウ",
    #   postal_code:"0000000",
    #   address:"東京",
    #   telephone_number:"00000000"
    # )

    # customer = Customer.new(
    #   email:"test1@mail.com",
    #   password:"password",
    #   last_name:"山田",
    #   first_name:"次郎",
    #   last_name_kana:"ヤマダ",
    #   first_name_kana:"次郎",
    #   postal_code:"0000000",
    #   address:"東京",
    #   telephone_number:"00000111"
    # )

    FactoryBot.create(:customer, email: "test1@mail.com")

    customer = FactoryBot.build(:customer, email: "test1@mail.com")

    customer.valid?

    expect(customer.errors[:email]).to include("has already been taken")

  end
end