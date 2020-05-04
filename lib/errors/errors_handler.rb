# frozen_string_literal: true

require 'yaml'

module Errors
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(StandardError, with: :handle_errors)
    end

    def handle_errors(err)
      error = Errors::Formatter.new(err).call

      render json: ErrorSerializer.new(error).serializable_hash, status: error.try(:status) || 422
    end
  end
end
