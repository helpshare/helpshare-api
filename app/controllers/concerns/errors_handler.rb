# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  Errors = [
    StandardError,
    API::Errors,
    ActiveRecord::RecordInvalid
  ]

  included do
    rescue_from(*Errors, with: binding.pry)
  end

  def handle_errors
    binding.pry
  end
end
