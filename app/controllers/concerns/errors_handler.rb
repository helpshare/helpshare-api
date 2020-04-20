# frozen_string_literal: true

module ErrorsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from(StandardError, with: handle_errors)
  end

  def handle_errors
    binding.pry
  end
end
