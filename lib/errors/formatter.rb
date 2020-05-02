# frozen_string_literal: true

module Errors
  class Formatter
    ErrorStruct = Struct.new(:message, :status, :class, keyword_init: true)

    def initialize(error)
      @error = error
    end

    # :reek:ManualDispatch
    def call
      return error if error.respond_to?(:message) && error.respond_to?(:status)

      case error
      when ActiveRecord::RecordInvalid
        error.record.errors.full_messages.map do |msg|
          ErrorStruct.new(message: msg, status: 422, class: error.class)
        end
      when StandardError
        ErrorStruct.new(message: error.message, status: 500, class: error.class)
      end
    end

    private

    attr_reader :error
  end
end
