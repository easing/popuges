# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"}, skip: [:registrations]

  root "dashboard#index"

  get 'up' => 'rails/health#show', as: :rails_health_check
end
