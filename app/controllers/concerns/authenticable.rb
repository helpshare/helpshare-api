# frozen_string_literal: true

module Authenticable
  def authenticate_user!(_options = {})
    raise Errors::Unauthenticated unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  def authenticate_user
    if request.headers['Authorization'].present? # rubocop:disable Style/GuardClause
      authenticate_or_request_with_http_token do |token|
        payload = JWT.decode(token, Rails.application.secrets.secret_key_base)

        @current_user_id = payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        raise Erros::Unauthenticated
      end
    end
  end
end
