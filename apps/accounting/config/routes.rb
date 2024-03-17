# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"}, skip: [:registrations]

  resources :transactions, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :billing_cycles, only: [:index, :show] do
    collection do
      post :close
    end
  end

  root to: redirect("/billing_cycles")

  get 'up' => 'rails/health#show', as: :rails_health_check
end
