# frozen_string_literal: true

module Authenticable
  ENTITIES = [User].freeze

  extend ActiveSupport::Concern

  ENTITIES.each do |entity|
    entity_name = entity.to_s.downcase

    define_method("current_#{entity_name}") do
      instance_variable_get("@current_#{entity_name}")
    end

    define_method("authenticate_#{entity_name}") do
      resource = entity.find(decode_auth_token["id"])
      instance_variable_set("@current_#{entity_name}", resource)
    end
  end

  def decode_auth_token
    JWT.decode(authorization_header, Rails.application.secret_key_base).first
  end

  # :reek:UtilityFunction
  def encode_auth_token(exp: 30.days, entity: User, id:)
    payload = {
      expt: exp,
      entity: entity,
      id: id
    }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def authorization_header
    @authorization_header ||= request.headers['Authorization']
  end
end
