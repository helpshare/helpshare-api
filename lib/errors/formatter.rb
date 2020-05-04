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
      when *HelpshareErrors::CUSTOM_ERRORS.keys
        custom_error
      when ActiveRecord::RecordInvalid
        error.record.errors.full_messages.map do |msg|
          ErrorStruct.new(message: msg, status: 422)
        end
      when Twilio::REST::RestError
        internal_server_error
      else
        internal_server_error
      end
    end

    private

    attr_reader :error

    def internal_server_error
      pretty_error = HelpshareErrors::InternalServerError.new
      ErrorStruct.new(message: pretty_error.message, status: pretty_error.status)
    end

    def active_record_errors
      error.record.errors.full_messages.map do |msg|
        ErrorStruct.new(message: msg, status: 422)
      end
    end

    def custom_error
      ErrorStruct.new(message: error.message, status: error.status)
    end
  end
end
