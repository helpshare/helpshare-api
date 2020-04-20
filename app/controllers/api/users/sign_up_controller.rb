# frozen_string_literal: true

module Users
  class SignUpController < ApplicationController
    def create
      user = User.create!(user_params)
      render json: UserSerializer.new(user).serialized_json
    end

    private

    def user_params
      params.permit(:email, :password)
    end
  end
end
