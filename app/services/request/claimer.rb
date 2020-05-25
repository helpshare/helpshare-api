# frozen_string_literal: true

class Request
  class Claimer
    NotFreshRequestError = Class.new(StandardError)

    def initialize(user_id:, request:)
      @user_id = user_id
      @request = request
    end

    def call
      validate!

      ActiveRecord::Base.transaction do
        UserRequest.create!(user_id: user_id, request_id: request.id)
        request.claimed!
      end
    end

    private

    attr_reader :user_id, :request

    def validate!
      unless request.fresh?
        raise NotFreshRequestError, "Request with id=#{request.id} already claimed or finished."
      end
    end
  end
end
