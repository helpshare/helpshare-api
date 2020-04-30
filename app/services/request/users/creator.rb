# frozen_string_literal: true

module Users
  class Creator
    def initialize(params: {})
      @params = params
    end

    def call
      user = User.create!(params)
    end

    private

    attr_reader :params
  end
end
