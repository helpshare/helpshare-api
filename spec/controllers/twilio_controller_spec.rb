# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwilioController, type: :controller do
  describe 'GET #sms' do
    context 'with valid params' do
      let(:params) do
        {
          'SmsMessageSid': 123,
          'From': '+48123456789',
          'Body': 'Zakupy',
          'FromCountry': 'PL',
          'FromState': '',
          'FromCity': ''
        }
      end

      it 'returns http success', :aggregate_failures do
        post :sms, params: params

        expect(response).to have_http_status(:success)
      end
    end
  end
end
