# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request::Creator do
  subject(:request_creator) { described_class.new(params: params) }

  let(:params) do
    {
      'SmsMessageSid': message_sid,
      'CallSid': call_sid,
      'From': from,
      'Body': 'I need groceries',
      'FromCountry': 'PL',
      'FromState': '',
      'FromCity': ''
    }.with_indifferent_access
  end
  let(:message_sid) { nil }
  let(:call_sid) { nil }

  describe '#persist' do
    context 'when saving sms request' do
      let(:message_sid) { '123' }

      context 'with valid params' do
        let(:from) { '+48123456789' }

        it 'saves a Request to database and returns a message', :aggregate_failures do
          expect { request_creator.persist }.to change(Request, :count).from(0).to(1)
          expect(request_creator.message).to include('We received your request.')
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

    context 'when saving voice request' do
      let(:call_sid) { '123' }

      context 'with valid params' do
        let(:from) { '+48123456789' }

        it 'saves a Request to database and returns a message', :aggregate_failures do
          expect { request_creator.persist }.to change(Request, :count).from(0).to(1)
          expect(request_creator.message).to include('We received your request')
          expect(request_creator.error).to eq('')
        end

        it "sets reception_type to 'voice'", :aggregate_failures do
          expect { request_creator.persist }.to change(Request, :count).from(0).to(1)
          expect(Request.last.through_voice?).to eq(true)
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

    context 'when both call_id and message_id is specified' do
      let(:message_sid) { '321' }
      let(:call_sid) { '123' }
      let(:from) { '+48123456789' }

      it 'returns error regarding doubled id', :aggregate_failures do
        expect { request_creator.persist }.not_to change(Request, :count)
        expect(request_creator.error).to include('Both Call ID and Message ID were specified.')
        expect(request_creator.message).to eq('')
      end
    end
  end
end
