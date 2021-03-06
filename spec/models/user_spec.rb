# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  describe '#email' do
    subject(:user) { build(:user, email: 'user@example.com') }

    before do
      create(:user, email: 'user@example.com')
    end

    it 'has unique email' do
      expect { user.save! } .to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#password' do
    let(:user) { build(:user, password: 'a') }

    it 'must be at least 6 characters length' do
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
