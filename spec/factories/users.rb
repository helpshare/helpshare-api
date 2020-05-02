# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password { 'password' }
    phone_number { Faker::PhoneNumber.cell_phone }

    sequence :email do |n|
      "user#{n}@example.com"
    end
  end
end
