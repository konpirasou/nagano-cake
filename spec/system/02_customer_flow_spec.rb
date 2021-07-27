require 'rails_helper'

describe '会員の登録〜注文のテスト' do
  context 'トップページのテスト' do
    let!(:customer) { create(:customer) }

    it '新規登録画面へのリンクを押すと新規登録画面が表示される' do
      visit root_path
      click_link '新規登録'
      expect(current_path).to eq new_customer_registration_path
    end
  end

  describe '新規登録画面のテスト' do
    before do
      visit new_customer_registration_path
      fill_in 'customer[last_name]', with: "令和"
      fill_in 'customer[first_name]', with: "道子"
      fill_in 'customer[last_name_kana]', with: "レイワ"
      fill_in 'customer[first_name_kana]', with: "ミチコ"
      fill_in 'customer[email]', with: "test@email.com"
      fill_in 'customer[postal_code]', with: "0000000"
      fill_in 'customer[address]', with: "東京都新宿区"
      fill_in 'customer[telephone_number]', with: "00000000"
      fill_in 'customer[password]', with: "password"
      fill_in 'customer[password_confirmation]', with: "password"
      click_link "新規登録"
    end

    context '新規登録画面のテスト' do
      it '必要事項を入力して登録ボタンを押下するとマイページに遷移する' do
        expect(current_path).to eq customer_my_page_path
      end

      it '新規登録画面で入力した情報が表示されている' do
        expect(page).to have_content '令和'
        expect(page).to have_content '道子'
        expect(page).to have_content 'レイワ'
        expect(page).to have_content 'ミチコ'
        expect(page).to have_content 'test@email.com'
        expect(page).to have_content '0000000'
        expect(page).to have_content '東京都新宿区'
        expect(page).to have_content '00000000'
      end

      it 'ヘッダーがログイン後の表示に変わっている' do
        expect(page).to have_link 'マイページ'
        expect(page).to have_link '商品一覧'
        expect(page).to have_link 'カート'
        expect(page).to have_link 'ログアウト'
      end
    end

    context 'ヘッダーロゴのテスト' do
    it 'ヘッダーロゴを押すとトップ画面に遷移する' do
        click_link 'Nagano Cake'
        expect(current_path).to eq root_path
      end
    end

    context 'トップ画面のテスト' do
      let!(:genre) { create(:genre) }
      let!(:product_1) { create(:product) }
      let!(:product_2) { create(:product) }

      it '商品画像を押すと該当商品の詳細画面に遷移する' do
        visit root_path
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
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product) }

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
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product) }
      let!(:cart_product) { create(:cart_product) }

      before do
        visit cart_products_path
      end

      it '買い物を続けるボタンを押すとトップ画面に遷移する' do
        click_button '買い物を続ける'
        expect(current_path).to eq root_path
      end

      it 'ヘッダーの商品一覧のリンクを押すと商品一覧画面に遷移する' do
        click_link "商品一覧"
        expect(current_path).to eq products_path
      end

      it '商品の個数を変更し、更新ボタンを押すと合計表示が正しく表示される' do
        fill_in 'cart_product[amount]', with: '3'
        click_button '変更'
        expect(page).to have_content (product.price * 1.1).to_s(:delimited) * 3
      end

      it '情報入力に進むボタンを押すと情報入力画面に遷移する' do
        click_button '情報入力に進む'
        expect(current_path).to eq  new_order_path
      end
    end

    context '注文情報入力画面のテスト' do
      let!(:customer) { create(:customer) }
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product) }
      let!(:cart_product) { create(:cart_product) }

      before do
        visit new_order_path
      end

      it '支払い方法の選択,住所の記入をし、確認画面へ進むボタンを押すと注文確認画面に遷移する' do #要確認
        choose 'order_payment_1'
        choose 'order_address_select_2'
        fill_in 'order[postal_code]', with: '1111111'
        fill_in 'order[address]', with: '東京都渋谷区'
        fill_in 'order[name]', with: '渋谷二郎'
        click_button '確認画面へ進む'
        expect(current_path).to eq orders_confirm_path
      end
    end

    context '注文確認画面のテスト' do
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product) }
      let!(:cart_product) { create(:cart_product) }

      before do
        visit new_order_path
        choose 'order_payment_1'
        choose 'order_address_select_2'
        fill_in 'order[postal_code]', with: '1111111'
        fill_in 'order[address]', with: '東京都渋谷区'
        fill_in 'order[name]', with: '渋谷二郎'
        click_button '確認画面へ進む'
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
    end

    context 'サンクスページのテスト' do
      it 'ヘッダーのマイページへのリンクを押すとマイページに遷移する' do
        visit orders_complete_path
        click_link 'マイページ'
        expect(current_path).to eq customer_my_page_path
      end
    end

    context 'マイページのテスト' do
      it '注文履歴の一覧のリンクを押すと注文履歴一覧画面へ遷移する' do
        visit customer_my_page_path
        find('a[href="/orders"]').click
        expect(current_path).to eq orders_path
      end
    end

    context '注文履歴一覧画面のテスト' do
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product) }
      let!(:cart_product) { create(:cart_product) }
      let!(:order) { create(:order) }

      before do
        visit orders_path
      end

      it '注文した商品の詳細表示ボタンを押すと注文詳細が表示される' do
        click_button '表示する'
        expect(current_path).to eq order_path(1)
      end
    end

    context '注文詳細画面のテスト' do
      let!(:genre) { create(:genre) }
      let!(:product) { create(:product) }
      let!(:cart_product) { create(:cart_product) }
      let!(:order) { create(:order) }

      before do
        visit order_path(1)
      end

      it '注文内容が正しく表示されている' do
        expect(page).to have_content order.created_at
        expect(page).to have_content order.address
        expect(page).to have_content order.total_price.to_s(:delimited)
        expect(page).to have_content '銀行振込'
      end

      it 'ステータスが「入金待ち」になっている' do
        expect(page).to have_content '入金待ち'
      end
    end
  end
end