require 'rails_helper'

describe '登録情報変更〜退会のテスト' do
  let!(:customer) { create(:customer) }
  let!(:genre) { create(:genre) }
  let!(:product) { create(:product) }
  let!(:cart_product) { create(:cart_product) }
  let!(:addresses) { create(:addresses) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end
    
  context 'マイページのテスト' do
    it '編集するを押すと会員情報編集画面に遷移する' do
      visit customer_my_page_path
      click_link '編集する'
      expect(current_path).to eq customer_my_page_edit_path
    end
  end

  context '会員情報編集画面とマイページのテスト' do
    before do
      fill_in 'customer[last_name]', with: "新宿"
      fill_in 'customer[first_name]', with: "一郎"
      fill_in 'customer[last_name_kana]', with: "シンジュク"
      fill_in 'customer[first_name_kana]', with: "イチロウ"
      fill_in 'customer[email]', with: "test@email.com"
      fill_in 'customer[postal_code]', with: "0000000"
      fill_in 'customer[address]', with: "東京都新宿区"
      fill_in 'customer[telephone_number]', with: "00000000"
      click_button '編集内容を保存'
    end

    it '全項目を編集し編集内容を保存を押すとマイページに遷移する' do
      expect(current_path).to eq customer_my_page_path
    end

    it 'マイページに変更した内容が表示されている' do
      expect(page).to have_content '新宿'
      expect(page).to have_content '一郎'
      expect(page).to have_content 'シンジュク'
      expect(page).to have_content 'イチロウ'
      expect(page).to have_content 'test@email.com'
      expect(page).to have_content '0000000'
      expect(page).to have_content '東京都新宿区'
      expect(page).to have_content '00000000'
    end

    it 'マイページで配送先の一覧を表示するボタンを押すと配送先一覧画面に遷移する' do
      find('a[href="/addresses"]').click
      expect(current_path).to eq addresses_path
    end
  end

  context '配送先一覧画面のテスト' do
    before do
      visit addresses_path
      fill_in 'addresses[postal_code]', with: '0000000'
      fill_in 'addresses[address]', with: '東京都渋谷区'
      fill_in 'addresses[name]', with: '新宿一郎'
      click_button '新規登録'
    end

    it '各項目を入力し、新規登録ボタンを押すと自画面が再描画される' do
      expect(current_path).to eq addresses_path
    end

    it '登録した内容が配送先一覧画面に反映されている' do
      expect(page).to have_content '0000000'
      expect(page).to have_content '東京都渋谷区'
      expect(page).to have_content '新宿一郎'
    end

    it 'ヘッダーのロゴを押すとトップ画面に遷移する' do
      find('a[href="/"]').click
      expect(current_path).to eq root_path
    end
  end

  context 'トップ画面のテスト' do
    before do
      visit root_path
    end

    it '商品画像を押すと該当商品の詳細画面に遷移する' do
      find('a[href="/products/1"]').click
      expect(current_path).to eq product_path(1)
    end
    
    it '押した商品の情報が正しく表示されている' do
      visit product_path(1)
      expect(page).to have_content product_1.name
      expect(page).to have_content product_1.image
      expect(page).to have_content (product_1.price * 1.1).to_s(:delimited)
      expect(page).to have_content product_1.genre_id
      expect(product_1.is_active).to be true
    end
  end

  context '商品詳細画面のテスト' do
    before do
      visit product_path(1)
      find("option[value='2']").select_option
      click_button 'カートに入れる'
    end

    it '個数を選択し、カートに入れるボタンを押すと、カート画面に遷移する' do
      expect(current_path).to eq cart_products_path
    end

    it 'カートの中身が正しく表示されている' do
      visit cart_products_path
      expect(page).to have_content product.name
      expect(page).to have_content (product.price * 1.1).to_s(:delimited)
      expect(page).to have_selector ("input[value='2']")
      expect(page).to have_content (product.price * 1.1).to_s(:delimited) * 2
    end
  end

  context 'カート画面のテスト' do
    before do
      visit cart_products_path
    end

    it '情報入力に進むボタンを押すと情報入力画面に遷移する' do
      click_button '情報入力に進む'
      expect(current_path).to eq  new_order_path
    end

  end

  context '注文情報入力画面のテスト' do
    before do
      visit new_order_path
      choose 'order_payment_1'
      choose 'order_address_select_2'
      fill_in 'order[postal_code]', with: '1111111'
      fill_in 'order[address]', with: '東京都渋谷区'
      fill_in 'order[name]', with: '渋谷二郎'
      click_button '確認画面へ進む'
    end

    it '任意の支払い方法、新しい住所を入力し、購入ボタンを押すと確認画面に遷移する' do
      expect(current_path).to eq orders_confirm_path
    end

    it '選択した商品、合計金額、配送方法などが表示されている' do
      expect(page).to have_content product.name
      expect(page).to have_content ((product.price * 1.1) * cart_product.amount + 800).to_s(:delimited)
      expect(page).to have_content '銀行振込'
    end

    it '確定ボタンを押すとサンクスページに遷移する' do
      click_button '注文を確定する'
      expect(current_path).to eq orders_complete_path
    end

    context 'サンクスページのテスト' do
      it 'サンクスページのヘッダーからロゴを押すとトップ画面に遷移する' do
        visit orders_complete_path
        click_link 'Nagano Cake'
        expect(current_path).to eq root_path
      end

      it 'トップ画面のヘッダーからマイページへのリンクを押すとマイページへ遷移する' do
        visit root_path
        click_link 'マイページ'
        expect(current_path).to eq customer_my_page_path
      end
    end

    context '配送先一覧画面のテスト' do
      before do
      visit customer_my_page_path
      choose 'order_payment_1'
      choose 'order_address_select_2'
      fill_in 'order[postal_code]', with: '1111111'
      fill_in 'order[address]', with: '東京都渋谷区'
      fill_in 'order[name]', with: '渋谷二郎'
      end

      it 'マイページで配送先一覧へのリンクを押すと配送先一覧画面へ遷移する' do
        find('a[href="/addresses"]').click
        expect(current_path).to eq addresses_path
      end

      it '配送先一覧画面に、注文時に新しく入力した住所が表示されている' do
        visit addresses_path
        expect(page).to have_content '1111111'
        expect(page).to have_content '東京都渋谷区'
        expect(page).to have_content '渋谷二郎'
      end
    end

    context '会員情報編集画面のテスト' do
      before do
        visit customer_mypage_path
      end
      
      it 'マイページで顧客情報編集画面へのリンクを押すと、顧客情報編集画面へ遷移する' do
        click_link '編集する'
        expect(current_path).to eq customer_my_page_edit_path
      end

      it '顧客情報編集画面で退会ボタンを押すと、アラートが表示される' do
        visit customer_my_page_edit_path
        click_link '退会する'
        expect(current_path).to eq customers_my_page_cancel_path
      end

      it '退会確認画面で「退会する」ボタンを押すと、トップ画面に遷移する' do
        visit customers_my_page_cancel_path
        click_link '退会する'
        expect(current_path).to eq root_path
      end
    end

    context '退会後の確認テスト' do
      before do
        visit customers_my_page_cancel_path
        click_link '退会する'
      end

      it '退会後のトップ画面で、ヘッダーが未ログイン状態になっている' do
        expect(page).to have_link 'ログイン'
        expect(page).to have_link 'About'
        expect(page).to have_link '新規登録'
      end

      it '退会後のトップ画面で、ヘッダーの「ログイン」リンクを押すとログイン画面に遷移する' do
        click_link 'ログイン'
        expect(current_path).to eq new_customer_session_path
      end

      it '退会したアカウントでログインができなくなっている' do
        visit new_customer_session_path
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
        expect(current_path).to eq new_customer_session_path
      end
    end
  end
end

describe '管理者ログイン〜ログアウトのテスト' do
  let!(:customer) { create(:customer) }
  let!(:admin) { create(:admin) }

  def admin_log_in
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end

  def customer_log_in
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end
  
  before do
    customer_log_in
    visit customers_my_page_cancel_path
    click_link '退会する'
    click_button 'ログアウト'
    admin_log_in
  end
  
  context '管理者ログインのテスト' do
    it 'ログイン後のリダイレクト先が、管理者トップ画面になっている' do
      expect(current_path).to eq admin_orders_path
    end
  end

  context '管理者トップ画面のテスト' do
    it 'ヘッダーから会員一覧のリンクを押すと会員一覧が表示される' do
      click_link '会員一覧'
      expect(current_path).to eq admin_customers_path
    end
  end

  context '会員一覧画面のテスト' do
    it '顧客一覧画面で退会ユーザが退会表示になっている' do
      visit admin_customers_path
      expect(page).to have_content customer.created_at
      expect(page).to have_content (customer.last_name + customer.first_name)
      expect(page).to have_content '退会'
      expect(customer.reload.is_deleted).to be true
    end
    
    it '顧客一覧画面で顧客の名前を押すと、該当の顧客詳細画面に遷移する' do
      visit admin_customers_path
      click_link (customer.last_name + customer.first_name)
      expect(current_path).to eq admin_customer_path(customer)
    end
  end
  
  context '会員情報詳細画面テスト' do
    it "ヘッダーからログアウトのリンクを押すと管理者ログイン画面に遷移する" do
      click_link "ログアウト"
      expect(current_path).to eq new_admin_session_path
    end
  end
end
