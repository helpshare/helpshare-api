# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :users do
    resources :login, only: %i[create]
    resources :registrations, only: %i[create]
  end
end

