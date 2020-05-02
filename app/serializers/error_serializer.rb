# frozen_string_literal: true

class ErrorSerializer
  include FastJsonapi::ObjectSerializer

  set_id do |_err, _params|
    DateTime.now.to_i.to_s
  end

  attributes :message, :kind

  attribute :kind do |obj|
    obj.class.name
  end
end
