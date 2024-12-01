# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: 'sessions#auth_failure'
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  resource :user, only: %i[update destroy]
  get 'user', to: 'users#edit', as: 'edit_user'
  resource :family, only: %i[show], as: 'family'
  resources :meal_plans do
    get 'calendar', on: :collection
    resources :meals, only: %i[new create]
  end
  resources :meeting_rooms, only: %i[show create] do
    resources :remarks, only: %i[new create edit update destroy]
  end
  get 'welcome', to: 'home#welcome'
  get 'terms', to: 'home#terms'
  get 'privacy', to: 'home#privacy'
  get 'about', to: 'home#about'
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest
  get 'up' => 'rails/health#show', as: :rails_health_check
end
