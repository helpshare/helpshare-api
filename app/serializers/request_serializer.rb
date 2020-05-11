class RequestSerializer
  include FastJsonapi::ObjectSerializer

  attributes :phone_number, :message_content, :created_at, :from_country, :from_state, :from_city
end
