# frozen_string_literal: true

module Stubs
  module Twilio
    def request_sms_confirmation_token(token:, recipent_number:)
      stub_request(:post, 'https://api.twilio.com/2010-04-01/Accounts/ACb3301fcf4a9bf8076e645fdefa51b350/Messages.json')
        .with(
          body: {
            'Body' => "Your registration token is: #{token}",
            'From' => Settings.twilio.phone_number, 'To' => "#{recipent_number}"
          },
        )
        .to_return(status: 200, body: '', headers: {})
    end
  end
end
