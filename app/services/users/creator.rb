# frozen_string_literal: true

module Users
  class Creator
    def initialize(params: {})
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        user = User.create!(params)
        RegistrationTokenCreator.new(user: user).call
        user
      end
    end

    private

    attr_reader :params
  end
end
