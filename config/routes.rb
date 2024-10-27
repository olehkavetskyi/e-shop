Rails.application.routes.draw do
  devise_for :users

  root to: "products#index"

  resources :categories, only: [:index, :show]

  resources :products do
    resources :comments, only: [:create]  # Nested resource for comments
    resources :ratings, only: [:create]    # Nested resource for ratings
  end

  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest"
end
