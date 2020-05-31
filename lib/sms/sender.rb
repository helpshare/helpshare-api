# frozen_string_literal: true

module Sms
  class Sender
    TWILIO_SETTINGS = Settings.twilio

    def initialize(
      from: TWILIO_SETTINGS['phone_number'],
      to:,
      message:,
      client: Twilio::REST::Client
    )
      @from = from
      @to = to
      @message = message
      @client = client
    end

    def call
      client.new(
        TWILIO_SETTINGS['account_sid'],
        TWILIO_SETTINGS['auth_token']
      ).messages.create(
        from: from,
        to: to,
        body: message
      )
    end

    private

    attr_reader :from, :to, :message, :client
  end
end
