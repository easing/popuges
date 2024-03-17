# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", sessions: "users/sessions"}, skip: [:registrations]

  resources :tasks, except: [:destroy] do
    member do
      patch :complete
    end

    collection do
      patch :reassign
      patch :mass_complete
      patch :mass_create
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  root "tasks#index"
end
