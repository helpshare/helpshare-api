# frozen_string_literal: true

module Users
  class Creator
    def initialize(params: {})
      @params = params
    end

    def call
      user = User.create!(params)
    end

    private

    attr_reader :params

    def unique_token
      SecureRandom.hex(4)
    end

    def send_sms_conirmation_token
      Sms::Sender.new(
        to: user.phone_number,
        message: "Your registration token is: #{unique_token}"
      ).call
    end
  end
end
