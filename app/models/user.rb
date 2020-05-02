# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_senstive: false }
  validates :password, length: { minimum: 6 }
  validates :registration_token, uniqueness: true, allow_nil: true
end
