Rails.application.routes.draw do
  devise_for :users

  # Root route
  root to: "products#index"

  # Category routes
  resources :categories, only: [:index, :show]

  # Product routes
  resources :products, except: :show do
    # Custom show route to include section in URL
    collection do
      get ':section/:id', to: 'products#show', as: 'show_product'
      get ':section', to: 'products#index', as: 'section'
    end

    # Nested routes for comments within products
    resources :comments, only: [:create] do
      # Member routes for like/dislike actions
      member do
        post :like   # Route for liking a comment
        post :dislike # Route for disliking a comment
      end
    end

    # Separate route for rating within the product scope
    post 'rate', to: 'comments#rate', as: 'rate'
  end

  # Cart and Checkout routes
  resource :cart, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  resource :checkout, only: [:show, :create], controller: 'checkout'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes for service worker and manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest"
end
