# frozen_string_literal: true

require 'yaml'

module Errors
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(StandardError, with: :handle_errors)
    end

    def handle_errors(error)
      raise error if Rails.env.development?

      error = Errors::Formatter.new(error).call

      render json: ErrorSerializer.new(error).serializable_hash, status: error.status
    end
  end
end
