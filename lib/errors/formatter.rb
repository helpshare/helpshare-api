# frozen_string_literal: true

module Errors
  class Formatter
    ErrorStruct = Struct.new(:message, :status, keyword_init: true)

    def initialize(error)
      @error = error
    end

    # :reek:ManualDispatch
    def call
      case error
      when ActiveRecord::RecordInvalid
        error.record.errors.full_messages.map do |msg|
          ErrorStruct.new(message: msg, status: 422)
        end
      when Twilio::REST::RestError
        pretty_error = HelpshareErrors::InternalServerError.new
        ErrorStruct.new(message: pretty_error.message, status: pretty_error.status)
      else
        ErrorStruct.new(message: error.message, status: 500)
      end
    end

    private

    attr_reader :error
  end
end
