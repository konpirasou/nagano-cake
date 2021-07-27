require 'rails_helper'

describe '製作〜発送のテスト' do
  let!(:admin) { create(:admin) }
  let!(:customer) { create(:customer) }
  let!(:genre) { create(:genre) }
  let!(:product) { create(:product) }
  let!(:product_2) { create(:product) }
  let!(:order) { create(:order) }
  let!(:order_product) { create(:order_product) }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button 'ログイン'
  end

  context '管理者ログインのテスト' do
    it 'ログイン後のリダイレクト先が、注文履歴一覧画面になっている' do
      expect(current_path).to eq admin_orders_path
    end
  end

  context '注文履歴一覧画面のテスト'
    before do
      visit admin_orders_path
    end

    it '注文の詳細表示ボタンを押すと注文詳細ページが表示される' do
      find('a[href="/products/1"]').click
      expect(current_path).to eq admin_order_path(order)
    end
  end

  context '注文詳細画面のテスト' do
    before do
      visit admin_order_path(order)
    end

    it '注文ステータスを入金確認に変更すると制作ステータスが制作待ちに更新される' do
      select "入金確認", from: 'order[status]'
      click_button '変更'
      expect(order_product.reload.product_status).to eq "製作待ち"
    end

    it '製作ステータスを１つ製作中に変更する' do
      select "製作中", from: 'order_product[product_status]'
      click_button '変更'
      expect(order.reload.status).to eq "製作中"
    end

    before do
      OrderProduct.create!(product_id: 1, order_id: 1, price: 2000, amount: 1, product_status: 3)
    end

    it '全ての商品の製作ステータスを製作完了にしたら注文ステータスが発送待ちに更新される' do
      select "製作完了", from: 'order_product[product_status]'
      click_button '変更'
      expect(order.reload.status).to eq '発送準備中'
    end

    it '注文ステータスを発送済みに変更し更新されるか' do
      select "発送済み", from: 'order[status]'
      click_button '変更'
      expect(order.reload.status).to eq '発送済み'
    end

    it "ヘッダーからログアウトのリンクを押すと管理者ログイン画面に遷移する" do
      click_link "ログアウト"
      expect(current_path).to eq new_admin_session_path
    end
  end

describe 'ECサイト側のテスト' do
  let!(:customer) {create(:customer)}
  let!(:genre) { create(:genre) }
  let!(:product) { create(:product) }
  let!(:order) { create(:order) }
  let!(:order_product) { create(:order_product) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  context '顧客のログインテスト' do
    it 'ログイン後、トップ画面に遷移している' do
      expect(current_path).to eq root_path
    end

    context 'ヘッダーがログイン後の表示になっている' do
      it 'ヘッダーにマイページのリンクがある' do
        expect(page).to have_link 'マイページ', href: customer_my_page_path
      end
      it 'ヘッダーに商品一覧ページのリンクがある' do
        expect(page).to have_link '商品一覧', href: products_path
      end
      it 'ヘッダーにカートページのリンクがある' do
        expect(page).to have_link 'カート', href: cart_products_path
      end
      it 'ヘッダーにログアウトのリンクがある' do
        expect(page).to have_link 'ログアウト', href: destroy_customer_session_path
      end
    end

    context 'ヘッダーからマイページへ遷移' do
      it 'マイページリンクを押すとマイページが表示される' do
        click_link 'マイページ'
        expect(current_path).to eq customer_my_page_path
      end
    end
  end

  context '顧客側の注文一覧ページのテスト' do
    before do
      visit customer_my_page_path
    end

    it 'マイページに注文履歴一覧のリンクが存在する' do
      expect(page).to have_link '一覧を見る', href: orders_path
    end

    it '注文履歴一覧を押すと注文履歴一覧ページが表示される' do
      find(href: '/orders').click
      expect(current_path).to eq orders_path
    end

    context '注文詳細ページのテスト' do
      before do
        visit orders_path
        Orderproduct.find(1).update(product_status: 3)
        Order.find(1).update(status: 4)
      end

      it '注文した注文詳細表示リンクがある' do
        expect(page).to have_link '表示する', href: order_path(1)
      end

      it '注文詳細履歴ボタンを押すと遷移する' do
        click_on '表示する'
        expect(current_path).to eq order_path(1)
      end
      it '注文ステータスが発送済みになっている' do
        visit order_path(1)
        expect(page).to have_content '発送済み'
      end
    end
  end
end