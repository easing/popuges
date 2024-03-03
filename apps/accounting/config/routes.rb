# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks" },
             skip: [:registrations]

  resources :transactions, only: [:index, :show]

  root to: redirect("/transactions")

  get 'up' => 'rails/health#show', as: :rails_health_check
end
