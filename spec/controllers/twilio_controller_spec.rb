# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwilioController, type: :controller do
  describe 'GET #sms' do
    let(:params) do
      {
        'SmsMessageSid': 123,
        'From': from,
        'Body': 'I need groceries',
        'FromCountry': 'PL',
        'FromState': '',
        'FromCity': ''
      }
    end

    context 'with valid params' do
      let(:from) { '+48123456789' }

      it 'returns http success', :aggregate_failures do
        expect { post :sms, params: params }.to change(Request, :count).from(0).to(1)
        expect(response).to have_http_status(:created)
        expect(response.body).to include('?xml version')
        expect(response.body).to include(
          "We received your request: 'I need ...'. Someone should reach out to you shortly."
        )
      end
    end

    context 'with incorrect params' do
      let(:from) { '' }

      it 'returns http success', :aggregate_failures do
        expect { post :sms, params: params }.not_to change(Request, :count)
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include('?xml version')
        expect(response.body).to include("Phone number can't be blank")
      end
    end
  end
end
