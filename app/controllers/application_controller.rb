# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  before_action :authenticate_user

  private

  def unauthorized_entity
    render json: { errors: 'Unauthenticated' }
  end
end
