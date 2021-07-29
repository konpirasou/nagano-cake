Rails.application.routes.draw do
  devise_for :customers, controllers: {
   registrations: 'public/customers/registrations',
   sessions:      'public/customers/sessions',
  }
  devise_for :admins, module: "admin/admins", path: "/admin"
  root :to => "public/homes#top"
  get "about" => "public/homes#about"
  resources :products, only: [:index, :show], controller: "public/products" do
    resources :comments, only: [:create, :destroy], controller: "public/comments"
    resource :favorites, only: [:create, :destroy], controller: "public/favorites"
  end
  resources :cart_products, only: [:index, :create, :update, :destroy], controller: "public/cart_products"
  delete "cart_products" => "public/cart_products#destroy_all", as: 'destroy_all'
  resources :customers, only: [:update], controller: "public/customers"
  get "customers/my_page" => "public/customers#show"
  get "customers/my_page/edit" => "public/customers#edit"
  get "customers/my_page/cancel" => "public/customers#cancel"
  patch "customers/my_page/cancel" => "public/customers#unsubscribe"
  post "orders/confirm" => "public/orders#confirm"
  get "orders/complete" => "public/orders#complete"
  resources :orders, only: [:index, :show, :new, :create], controller: "public/orders"
  resources :addresses, only: [:index, :create, :edit, :update, :destroy], controller: "public/addresses"
  get "search" => "public/searches#search"

  namespace :admin do
    get "/" => "orders#index"
    resources :products, only: [:index,:show, :new, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :order_products, only: [:update]
    get "search" => "searches#search"
  end
end
