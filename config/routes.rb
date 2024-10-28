Rails.application.routes.draw do
  devise_for :users

  root to: "products#index"

  resources :categories, only: [:index, :show]

  resources :products do
    resources :comments, only: [:create] do
      member do
        post :like     # Route for liking a comment
        post :dislike  # Route for disliking a comment
      end
    end
    resources :ratings, only: [:create]
  end

  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest"
end
