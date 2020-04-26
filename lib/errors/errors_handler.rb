# frozen_string_literal: true

module Errors
  module ErrorsHandler
    extend ActiveSupport::Concern

    DEFINED_ERRORS = [
      *HelpshareErrors::ERRORS.keys,
      HelpshareErrors::Unauthenticated
    ].freeze

    included do
      binding.pry
      rescue_from(*DEFINED_ERRORS, with: :handle_errors)
    end

    private

    def handler_errors(err)
      error_message = find_error_message(err) || err.message
      render json: ErrorSerializer.new(err).serialized_json
    end

    def find_error_message(err)
      binding.pry
    end
  end
end
