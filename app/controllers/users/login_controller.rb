# frozen_string_literal: true

module Users
  class LoginController < ApplicationController
    def create
      user = User.find_by!(email: params[:email])
      user.authenticate(params[:password])

      binding.pry
      if user
        render json: { token: encode_auth_token(id: user.id) }
      else
        render json: {}, head: :unauthenticated
      end
    end

    private

    def login_params
      params.permit(:email, :password)
    end
  end
end
