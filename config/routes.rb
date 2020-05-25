# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    namespace :users do
      resources :login, only: %i[create]
      resources :sign_up, only: %i[create]
    end
    scope :requests do
      get '', to: 'requests#index'
      post '/:id/claim', to: 'requests#claim'
    end
    post 'twilio', to: 'twilio#create'
  end
end
