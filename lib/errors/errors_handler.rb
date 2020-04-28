# frozen_string_literal: true

require 'yaml'

module Errors
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(StandardError, with: :handle_errors)
    end

    #:reek:FeatureEnvy, :reek:ManualDispatch
    def handle_errors(err)
      error = Errors::Formatter.new(err).call
      status = error.respond_to?(:size) ? error.first.status : error.status

      render json: ErrorSerializer.new(error).serializable_hash, status: status
    end
  end
end
