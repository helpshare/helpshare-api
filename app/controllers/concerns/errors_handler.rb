# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  API_ERRORS = [
    DefinedErrors::DefinedError
  ].freeze

  included do
    rescue_from(*API_ERRORS, with: :handle_errors)
  end

  def handle_errors(error)
    render json: { errors: error.message }, status: error.status
  end
end
