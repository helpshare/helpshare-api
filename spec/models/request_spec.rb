# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  context 'without a phone number' do
    it 'does not save a record', :aggregate_failures do
      request = described_class.new(phone_number: '', message_content: 'Groceries')

      expect { request.save }.not_to change(described_class, :count)
      expect(request.errors.full_messages).to include("Phone number can't be blank")
    end
  end

  context 'without a message content' do
    it 'does not save a record', :aggregate_failures do
      request = described_class.new(phone_number: '123456789', message_content: '')

      expect { request.save }.not_to change(described_class, :count)
      expect(request.errors.full_messages).to include("Message content can't be blank")
    end
  end

  context 'without an outer service id' do
    it 'does not save a record', :aggregate_failures do
      request = described_class.new(
        phone_number: '123456789', message_content: 'Walk a dog', outer_service_id: ''
      )

      expect { request.save }.not_to change(described_class, :count)
      expect(request.errors.full_messages).to include("Outer service can't be blank")
    end
  end

  context 'with valid phone number and mesage content' do
    it 'saves a record', :aggregate_failures do
      request = described_class.new(
        phone_number: '123456789', message_content: 'Pharmacy', outer_service_id: '123'
      )

      expect { request.save }.to change(described_class, :count).from(0).to(1)
      request.reload
      expect(request.phone_number).to eq('123456789')
      expect(request.message_content).to eq('Pharmacy')
      expect(request.outer_service_id).to eq('123')
    end
  end
end
