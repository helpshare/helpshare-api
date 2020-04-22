# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  API_Errors = [
    StandardError,
    API::Errors,
    ActiveRecord::RecordInvalid
  ]

  included do
    rescue_from(*API_Errors, with: :handle_errors)
  end

  def handle_errors(e)
    render json: { errors: e.message }
  end
end
