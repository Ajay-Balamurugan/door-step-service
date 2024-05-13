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

  resources :service_request_items, only: %i[show edit update index create destroy]

  resources :services do
    resources :options
  end

  # Defines the root path route ("/")
  root 'customers#home'

  # Admin Dashboard
  get 'admin_dashboard', to: 'admins#home'

  # employee Dashboard
  get 'employee_dashboard', to: 'employees#home'

  # verify otp from customer
  post 'verify_otp', to: 'employees#verify_otp', as: 'verify_otp'

  # send the OTP SMS to customer
  post 'send_otp', to: 'employees#send_otp'

  # Download service history
  post 'download_history', to: 'service_request_items#download_history'

  # download invoice pdf
  post 'download_invoice', to: 'service_request_items#download_invoice'
end
