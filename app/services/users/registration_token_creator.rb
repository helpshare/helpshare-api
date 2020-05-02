# frozen_string_literal: true

module Users
  class RegistrationTokenCreator
    def initialize(user:)
      @user = user
    end

    def call
      user.update!(registration_token: token)
      user.send_sms_conirmation_token
    end

    private

    attr_reader :user

    def send_sms_conirmation_token
      Sms::Sender.new(
        to: user.phone_number,
        message: "Your registration token is: #{token}"
      ).call
    end

    def token
      @token ||= SecureRandom.hex(4)
    end
  end
end
