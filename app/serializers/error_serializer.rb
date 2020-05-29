# frozen_string_literal: true

class ErrorSerializer
  include FastJsonapi::ObjectSerializer

  set_id do |_err, _params|
    "#{err.class.name}_#{SecureRandom.hex(20)}"
  end

  attributes :message
end
