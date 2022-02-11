Rails.application.routes.draw do
  resources :wishlists
  resources :orders do
    get 'checkout'
    post 'checkout'
    get 'purchase_complete'
  end
  namespace :admin do
      resources :users
      resources :orders
      # resources :carts
      root to: "users#index"
    end
  resources :line_items
  resources :carts
  resources :products do
    collection do
      get 'search'
      post 'search'
    end
  end
  post 'line_items/update_item'
  get 'users/index'
  devise_for :users
  resources :users, :only=>[:show,:edit]
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
