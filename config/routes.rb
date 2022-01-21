Rails.application.routes.draw do
  resources :line_items
  resources :carts
  resources :products
  get 'users/index'
  devise_for :users
  resources :users, :only=>[:show,:edit]
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
