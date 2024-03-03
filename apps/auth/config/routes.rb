# frozen_string_literal: true

require 'karafka/web'

Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  resources :users, only: [:index, :show]

  root "users#index"

  get 'up' => 'rails/health#show', as: :rails_health_check

  mount Karafka::Web::App, at: '/karafka'
end
