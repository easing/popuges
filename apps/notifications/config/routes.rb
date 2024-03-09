# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"}, skip: [:registrations]

  resources :notifications, only: [:index, :show]
  root to: redirect("/notifications")

  get 'up' => 'rails/health#show', as: :rails_health_check
end
