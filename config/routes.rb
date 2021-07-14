Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  root :to => "homes#top"
  get "about" => "homes#about"
  resources :products, only: [:index, :show]
  resources :cart_products, only: [:index, :update, :destroy]
  delete "cart_products" => "cart_products#destroy_all"
  resources :customers, only: [:show, :edit, :update]
  get "customers" => "customers#cancel"
  patch "customers" => "customers#unsubscribe"
  resources :orders, only: [:index, :show, :new, :create]
  post "orders" => "orders#confirm"
  get "orders" => "orders#complete"
  resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  get "search" => "searches#search"

  namespace :admin do
    root :to => "orders#index"
    resources :products, only: [:index,:show, :new, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    patch "order_products" => "order_products#update"
    get "search" => "searches#search"
  end
end
