Rails.application.routes.draw do
  devise_for :users

  resources :customers, only: [:new, :create, :edit, :update]
  resources :employees, only: [:new, :create, :edit, :update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "customers#home"

  # Admin Dashboard
  get "admin_dashboard", to:"admins#home" 

  #employee Dashboard
  get "employee_dashboard", to:"employees#home"
end
