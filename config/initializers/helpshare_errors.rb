# frozen_string_literal: true

require 'yaml'

module HelpshareErrors
  class Unauthenticated < StandardError; end

  CUSTOM_ERRORS = {
    Unauthenticated => :unauthenticated
  }

  ERRORS_MESSAGES = YAML.load(File.read('config/errors.yml')).dig('errors')

  CUSTOM_ERRORS.each do |error, error_sym|
    error.class_eval do |klass|
      define_method(:message) do
        ERRORS_MESSAGES.dig("#{error_sym}", 'message')
      end

      define_method(:status) do
        ERRORS_MESSAGES.dig("#{error_sym}", 'status')
      end
    end
  end
end
