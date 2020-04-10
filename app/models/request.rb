class Request < ApplicationRecord
  validates :phone_number, :message_content, presence: true
end
