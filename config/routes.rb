Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "api/v1/users/sessions" }

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Namespace for API routes
  namespace :api do
    namespace :v1 do
      resources :products, only: [ :index, :show, :create, :update, :destroy ]
      resources :orders, only: [ :index, :show, :create ]
    end
  end
end
