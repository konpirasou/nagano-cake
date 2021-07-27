require 'rails_helper'

describe "マスタ登録テスト" do
  let(:admin) { create(:admin) }

  before do
    visit new_admin_session_path #"/admin/sign_in"でも可 expect(current_path)なので_path表記
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end

  context '管理者ログインのテスト' do
    it 'ログイン後のリダイレクト先が、管理者トップ画面になっている' do
      expect(current_path).to eq admin_orders_path
    end
  end

  context '管理者トップ画面のテスト' do
    it "ログイン後、ヘッダーにジャンル一覧のリンクが表示されている" do
      expect(page).to have_link "ジャンル一覧"
    end

    it "ジャンル一覧のリンクを押すとジャンル一覧画面が表示される" do
      click_link "ジャンル一覧"
      expect(current_path).to eq admin_genres_path
    end
  end

  context "ジャンル一覧画面のテスト" do
    before do
      visit admin_genres_path
    end

    it "必要事項を入力し、登録ボタンを押すと追加したジャンルが表示されている" do
      fill_in "genre[name]", with: "ケーキ"
      click_button "新規登録"
      expect(page).to have_content "ケーキ"
    end

    it "ヘッダーから商品一覧のリンクを押すと商品一覧画面が表示される" do
      click_link "商品一覧"
      expect(current_path).to eq admin_products_path
    end
  end

  context "商品一覧画面のテスト" do
    before do
      visit admin_products_path
    end

    it "商品追加のリンクを押すと商品新規登録画面が表示される" do
      click_link "商品追加"
      expect(current_path).to eq new_admin_product_path
    end
  end

  context "商品新規登録画面のテスト" do
    let!(:genre) { create(:genre) }
    before do
      visit new_admin_product_path
    end

    it "必要事項を入力して登録ボタンを押すと登録した商品の詳細画面に遷移する" do
      select genre.name, from: 'product[genre_id]'
      fill_in "product[name]", with: "test1"
      fill_in "product[introduction]", with: "test1"
      fill_in "product[price]", with: 1000
      attach_file "product[image]", "#{Rails.root}/app/assets/images/eclair-3366430_640.jpg"
      click_button "新規登録"
      expect(page).to have_content "商品詳細"
      expect(page).to have_content "test1"
      expect(page).to have_content "ケーキ"
    end
  end

  context "商品詳細画面のテスト" do
    let!(:genre) { create(:genre) }
    let!(:product) { create(:product) }

    before do
      visit admin_product_path(product)
    end

    it "ヘッダーから商品一覧のリンクを押すと商品一覧画面が表示される" do
      click_link "商品一覧"
      expect(current_path).to eq admin_products_path
    end
  end

  context "商品一覧画面のテスト" do
    let!(:genre) { create(:genre) }
    let!(:product) { create(:product) }

    before do
      visit admin_product_path(product)
    end

    it "登録した商品が表示されている" do
      expect(page).to have_content product.id
      expect(page).to have_content product.name
      expect(page).to have_content product.price
      expect(page).to have_content product.genre.name
      expect(page).to have_content "販売中"
    end

    it "商品追加のリンクを押すと商品新規登録画面が表示される" do
      click_link "商品一覧"
      expect(current_path).to eq admin_products_path
    end
  end

  context "商品新規登録画面のテスト(2商品目)" do
    let!(:genre) { create(:genre) }
    let!(:product) { create(:product) }

    before do
      visit new_admin_product_path
    end

     it "必要事項を入力して登録ボタンを押すと登録した商品の詳細画面に遷移する" do
      select genre.name, from: 'product[genre_id]'
      fill_in "product[name]", with: "test2"
      fill_in "product[introduction]", with: "test2"
      fill_in "product[price]", with: 1000
      attach_file "product[image]", "#{Rails.root}/app/assets/images/eclair-3366430_640.jpg"
      click_button "新規登録"
      expect(current_path).to eq admin_product_path(2)
      expect(page).to have_content "商品詳細"
      expect(page).to have_content "test2"
      expect(page).to have_content "ケーキ"
    end
  end

  context "商品詳細画面のテスト(2商品目登録後)" do
    let!(:genre) { create(:genre) }
    let!(:product_1) { create(:product) }
    let!(:product_2) { create(:product) }

    before do
      visit admin_product_path(product_2)
    end
  
    it "ヘッダーから商品一覧のリンクを押すと商品一覧画面が表示される" do
      click_link "商品一覧"
      expect(current_path).to eq admin_products_path
    end
  end
  
  context "商品一覧画面のテスト(2商品目登録後)" do
    let!(:genre) { create(:genre) }
    let!(:product_1) { create(:product) }
    let!(:product_2) { create(:product) }

    before do
      visit admin_products_path
    end

    it "登録した商品が表示されている(2商品)" do
      expect(page).to have_content product_1.id
      expect(page).to have_content product_1.name
      expect(page).to have_content product_1.price
      expect(page).to have_content product_1.genre.name
      expect(page).to have_content "販売中"
      expect(page).to have_content product_2.id
      expect(page).to have_content product_2.name
      expect(page).to have_content product_2.price
      expect(page).to have_content product_2.genre.name
      expect(page).to have_content "販売中"
    end

    it "ヘッダーからログアウトのリンクを押すと管理者ログイン画面に遷移する" do
      click_link "ログアウト"
      expect(current_path).to eq new_admin_session_path
    end
  end
end