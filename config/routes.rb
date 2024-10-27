Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users

  # Root path route
  root to: 'products#index'  # Set this to the desired home page

  # Resources for categories
  resources :categories, only: [ :index, :show ]  # Make sure the :show action is included

  # Resources for products
  resources :products do
    resources :comments, only: [ :create ]  # Nested resource for comments
  end

  # resources :cart, only: [:show] do
  #   post 'add/:product_id', to: 'carts#add_to_cart', as: 'add_to'
  #   delete 'remove/:product_id', to: 'carts#remove_from_cart', as: 'remove_from'
  # end

  # Cart routes
  resource :cart, only: [ :show ]
  resources :cart_items, only: [ :create, :update, :destroy ]

  # Other routes...
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest"
end
