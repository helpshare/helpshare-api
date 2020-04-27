# frozen_string_literal: true

require 'yaml'

module Errors
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(*HelpshareErrors::ERRORS.keys, with: :handle_custom_errors)
      rescue_from(ActiveRecord::RecordInvalid, with: :handle_ar_errors)
    end

    def handle_custom_errors(err)
      render json: ErrorSerializer.new(err).serialized_json, status: err.status
    end

    def handle_ar_errors(err)
      render json: { errors: err.record.errors.full_messages }, status: 422
    end
  end
end
