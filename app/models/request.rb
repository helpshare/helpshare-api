# frozen_string_literal: true

class Request < ApplicationRecord
  validates :phone_number, :message_content, presence: true
end
