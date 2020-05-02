# frozen_string_literal: true

module Users
  class SignUpController < ApplicationController
    def create
      user = Users::Creator.new(params: user_params).call
      render json: UserSerializer.new(user).serialized_json
    end

    private

    def user_params
      params.permit(:email, :password, :phone_number)
    end
  end
end
