# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper do
    controllers token_info: "token_info"
  end

  devise_for :users

  resources :users, only: [:index, :show] do
    collection do
      post "new", to: "users#create_popug", as: :create_popug
      post "employ", to: "users#employ_popugs", as: :employ_popugs
      post "fire", to: "users#fire_popugs", as: :fire_popugs
    end
  end

  root "users#index"

  get 'up' => 'rails/health#show', as: :rails_health_check
end
