Rails.application.routes.draw do
  devise_for :users, skip: [ :sessions, :passwords, :confirmations, :unlocks ], controllers: {
    registrations: "api/v1/users/registrations",
    sessions: "api/v1/users/sessions"
  }

  devise_scope :user do
    post "api/v1/users", to: "api/v1/users/registrations#create", as: :api_v1_user_registration
    post "api/v1/users/sign_in", to: "api/v1/users/sessions#create", as: :api_v1_user_session
    delete "api/v1/users/sign_out", to: "api/v1/users/sessions#destroy", as: :destroy_api_v1_user_session
  end

  get "up", to: "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :products, only: %i[ index show create update destroy ]
      resources :orders, only: %i[ index show create destroy ] do
        member do
          patch :mark_as_paid
        end
      end
    end
  end
end
