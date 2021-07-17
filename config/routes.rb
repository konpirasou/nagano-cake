Rails.application.routes.draw do
  devise_for :customers, controllers: {
   registrations: 'public/customers/registrations',
   sessions:      'public/customers/sessions',
  }
  devise_for :admins, module: "admin/admins", path: "/admin"
  root :to => "public/homes#top"
  get "about" => "public/homes#about"
  resources :products, only: [:index, :show], controller: "public/products"
  resources :cart_products, only: [:index, :update, :destroy], controller: "public/cart_products"
  delete "cart_products" => "public/cart_products#destroy_all"
  resources :customers, only: [:update], controller: "public/customers" #showを削除
  get "customers/my_page" => "public/customers#show"                           #showアクションのurlをmy_pageに変更
  get "customers/my_page/edit" => "public/customers#edit"
  get "customers/my_page/cancel" => "public/customers#cancel"
  patch "customers/my_page/cancel" => "public/customers#unsubscribe"
  resources :orders, only: [:index, :show, :new, :create], controller: "public/orders"
  post "orders" => "public/orders#confirm"
  get "orders" => "public/orders#complete"
  resources :addresses, only: [:index, :create, :edit, :update, :destroy], controller: "public/addresses"
  get "search" => "public/searches#search"

  namespace :admin do
    get "/" => "orders#index"
    resources :products, only: [:index,:show, :new, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    patch "order_products" => "order_products#update"
    get "search" => "searches#search"
  end
end
