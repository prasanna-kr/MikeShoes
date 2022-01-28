Rails.application.routes.draw do
  resources :line_items
  resources :carts do
    get 'checkout'
    post 'checkout'
    get 'purchase_complete'
  end
  resources :products do
    collection do
      get 'search'
      post 'search'
    end
  end
  post 'line_items/create'
  get 'users/index'
  devise_for :users
  resources :users, :only=>[:show,:edit]
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
