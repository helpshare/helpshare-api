# frozen_string_literal: true

class Request < ApplicationRecord
  validates :phone_number, :message_content, :outer_service_id, presence: true
end
