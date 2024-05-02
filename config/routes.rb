Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :employees, only: %i[new create edit update]

  resources :admins, only: %i[new create]

  resources :cart_items, only: %i[create update destroy]

  resources :carts, only: %i[show]

  resources :service_requests, only: %i[create index show]

  resources :employee_slots, only: %i[create]

  resources :service_request_items, only: %i[show]

  resources :services do
    resources :options
  end

  # Defines the root path route ("/")
  root 'customers#index'

  # Admin Dashboard
  get 'admin_dashboard', to: 'admins#index'

  # employee Dashboard
  get 'employee_dashboard', to: 'employees#index'

  # service show page for customers
  get 'show_service/:id', to: 'customers#home', as: 'show_service'
end
