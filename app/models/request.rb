# frozen_string_literal: true

class Request < ApplicationRecord
  enum reception_type: { sms: 0, voice: 1 }, _prefix: :through
  validates :phone_number, :message_content, :outer_service_id, :reception_type, presence: true

  before_validation :add_message_if_voice_request

  private

  def add_message_if_voice_request
    self.message_content = 'Voice call. No explicit message.' if through_voice?
  end
end
