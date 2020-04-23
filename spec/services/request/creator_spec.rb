# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request::Creator do
  subject(:request_creator) { described_class.new(params: params) }

  let(:params) do
    {
      'SmsMessageSid': 123,
      'From': from,
      'Body': 'I need groceries',
      'FromCountry': 'PL',
      'FromState': '',
      'FromCity': ''
    }.with_indifferent_access
  end

  describe '#persist' do
    context 'with valid params' do
      let(:from) { '+48123456789' }

      it 'saves a Request to database and returns a message', :aggregate_failures do
        expect { request_creator.persist }.to change(Request, :count).from(0).to(1)
        expect(request_creator.message).to include('I need ...')
        expect(request_creator.error).to eq('')
      end
    end

    context 'with incorrect params' do
      let(:from) { '' }

      it 'saves a Request to database and returns a message', :aggregate_failures do
        expect { request_creator.persist }.not_to change(Request, :count)
        expect(request_creator.error).to include("Phone number can't be blank")
        expect(request_creator.message).to eq('')
      end
    end
  end
end
