# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    user = User.find_by!(email: sign_in_params[:email])
    raise Erros::Unauthenticated unless user&.valid_password(password)

    @current_user = user
  end

  private

  def password
    sign_in_params[:password]
  end

  def email
    sign_in_params[:email]
  end
end
