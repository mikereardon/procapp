Rails.application.routes.draw do
  resources :rfps do
    resources :rfp_interests, only: [ :create, :destroy ]
    resources :proposals
  end

  # Add a route for viewing interested RFPs
  get "interested_rfps", to: "rfps#interested", as: :interested_rfps


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "welcome#index"
end
