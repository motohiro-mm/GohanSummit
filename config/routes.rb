# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  resources :sessions, only: %i[create destroy]
  resource :user, only: %i[update destroy]
  get 'user', to: 'users#edit', as: 'edit_user'
  get 'family', to: 'families#show', as: 'family'
  get 'meal_plans/calendar', to: 'meal_plans#calendar'
  resources :meal_plans do
    resources :meals, only: %i[new]
  end
  resources :meeting_rooms, only: %i[show create] do
    resources :remarks, only: %i[new create edit update destroy]
  end
  get 'welcome', to: 'home#welcome'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
