# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_one :user_request
  has_one :request, through: :user_request

  validates :email, presence: true, uniqueness: { case_senstive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
