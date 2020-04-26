# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Errors::ErrorHandler
  include Authenticable

  private

  def unauthorized_entity
    render json: { errors: 'Unauthenticated' }
  end
end
