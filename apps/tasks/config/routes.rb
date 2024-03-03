# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :tasks, except: [:destroy]

  get 'up' => 'rails/health#show', as: :rails_health_check

  # root "tasks#index"
end
