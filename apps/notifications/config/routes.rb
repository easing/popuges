# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  resources :notifications, only: [:index, :show]

  root "notifications#index"
end
