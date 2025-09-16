Rails.application.routes.draw do
devise_for :admin_users, ActiveAdmin::Devise.config
ActiveAdmin.routes(self)

devise_for :users, controllers: { registrations: "users/registrations" }

resources :users, only: [:show, :update]
resources :products, only: [:index, :show]
resources :addresses, only: [:create]
resources :cart_items, only: [:update, :destroy]
resources :invoices, only: [:create, :show]

get "about", to: "pages#about"
get "contact", to: "pages#contact"
get "/cart", to: "cart#show", as: "cart"
post "/cart_items", to: "cart_items#create", as: "add_to_cart"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
