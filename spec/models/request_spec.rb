require 'rails_helper'

RSpec.describe Request, type: :model do
  context 'without a phone number' do
    it 'does not save a record' do
      request = Request.new(phone_number: '', message_content: 'Groceries')

      expect { request.save }.not_to change(Request, :count)
      expect(request.errors.full_messages).to include("Phone number can't be blank")
    end
  end

  context 'without a message content' do
    it 'does not save a record' do
      request = Request.new(phone_number: '123456789', message_content: '')

      expect { request.save }.not_to change(Request, :count)
      expect(request.errors.full_messages).to include("Message content can't be blank")
    end
  end

  context 'valid phone number and mesage content' do
    it 'saves a record' do
      request = Request.new(phone_number: '123456789', message_content: 'Pharmacy')

      expect { request.save }.to change(Request, :count).from(0).to(1)
      request.reload
      expect(request.phone_number).to eq('123456789')
      expect(request.message_content).to eq('Pharmacy')
    end
  end
end
