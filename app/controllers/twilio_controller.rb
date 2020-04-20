# frozen_string_literal: true

class TwilioController < ApplicationController
  def sms
    if new_request.save
      render xml: twilio_response.to_s, status: 201
    else
      render xml: { error: new_request.errors.full_messages.join(' ') }, status: 404
    end
  end

  private

  def twilio_params
    params.permit(
      'SmsMessageSid', 'From', 'Body', 'FromCountry', 'FromState', 'FromCity'
    )
  end

  def new_request
    Request.new(
      outer_service_id: twilio_params['SmsMessageSid'],
      phone_number: twilio_params['From'],
      message_content: twilio_params['Body'],
      from_country: twilio_params['FromCountry'],
      from_state: twilio_params['FromState'],
      from_city: twilio_params['FromCity']
    )
  end

  def twilio_response
    Twilio::TwiML::MessagingResponse.new do |res|
      res.message body: 'Thank you for your request. Someone should reach out to you shortly.'
    end
  end
end
