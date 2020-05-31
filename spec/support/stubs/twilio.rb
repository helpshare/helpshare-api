# frozen_string_literal: true

module Stubs
  module Twilio
    def request_sms_confirmation_token
      stub_request(
        :post,
        "https://api.twilio.com/2010-04-01/Accounts/#{Settings.twilio.account_sid}/Messages.json"
      )
        .to_return(status: 200, body: '', headers: {})
    end
  end
end
