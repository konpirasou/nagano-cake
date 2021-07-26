require 'rails_helper'

RSpec.describe Admin, type: :model do
  
  #メールアドレス、パスワードがあれば有効な状態であること
  it "is valid with a email and password" do
    
    expect(FactoryBot.build(:admin)).to be_valid
    
  end
  
  #メールアドレスがなければ無効な状態であること
  it "is invalid without an email" do
  
    admin = FactoryBot.build(:admin, email: nil)
  
    admin.valid?
  
    expect(admin.errors[:email]).to include("can't be blank")

  end
end
