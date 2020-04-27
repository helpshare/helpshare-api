# frozen_string_literal: true

require 'yaml'

module Errors
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(HelpshareErrors::Unauthenticated, with: :handle_errors)
    end

    def handle_errors(err)
      render json: ErrorSerializer.new(err).serialized_json
    end
  end
end
