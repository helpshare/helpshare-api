# frozen_string_literal: true


module DefinedErrors
  class DefinedError < StandardError
    attr_reader :status

    def initialize(message = nil, status: 422)
      @message = default_error_message(message)

      super(@message)

      @status = status
    end

    private

    def default_error_message(message)
      MESSAGES.fetch(message, "Something went wrong")
    end
  end

  MESSAGES = {
    unauthenticated: "Invalid email or password"
  }
end
