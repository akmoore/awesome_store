Rails.application.routes.draw do
  
  get 'shop' => 'storefront#index'
  get 'about' => 'storefront#about'

  resource :cart, only: [:edit, :update, :destroy] #=> resource without the only filter will give access to all routes except 'index' route, the url is singular eg. /cart instead of /carts
  resources :line_items, only: [:create]
  resources :orders, only: [:new, :create, :show]

  devise_for :users
  scope :admin do
    resources :products
    resources :brands
    resources :categories
  end

  root 'storefront#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
