# frozen_string_literal: true

class ErrorSerializer
  include FastJsonapi::ObjectSerializer

  set_id do |_err, _params|
    DateTime.now.to_i.to_s
  end

  attributes :message
end
