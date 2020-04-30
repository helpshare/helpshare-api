# frozen_string_literal: true

module Sms
  class Sender
    def initialize(from:, to:, message:, client: Twilio::REST::Client)
      @from = from
      @to = to
      @message = message
      @client = client
    end

    def call
      client.new(account_sid, auth_token).messages.create(
        from: from,
        to: to,
        body: message
      )
    end

    private

    attr_reader :from, :to, :message, :client

    def account_sid
      ENV['ACCOUNT_SID']
    end

    def auth_token
      ENV['AUTH_TOKEN']
    end
  end
end
