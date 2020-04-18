# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_jwt
    JWT.encode(
      {
        id: id,
        exp: 30.days.from_now.to_i
      },
      Rails.application.secrets.secret_key_base
    )
  end
end
