# frozen_string_literal: true

module Users
  class LoginController < ApplicationController
    def create
      raise HelpshareErrors::Unauthenticated unless user

      render json: { auth_token: encode_auth_token(id: user.id) }
    end

    private

    def login_params
      params.permit(:email, :password)
    end

    def user
      user = User.find_by!(email: params[:email])
      user.authenticate(params[:password])
    end
  end
end
