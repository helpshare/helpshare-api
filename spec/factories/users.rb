# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'password' }
    phone_number { "+48666#{rand(999)}#{rand(999)}" }

    sequence :email do |n|
      "user#{n}@example.com"
    end
  end
end
