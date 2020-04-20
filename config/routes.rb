# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    namespace :users do
      resources :login, only: %i[create]
      resources :sign_up, only: %i[create]
    end
  end
end
