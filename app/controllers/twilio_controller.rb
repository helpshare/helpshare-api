# frozen_string_literal: true

class TwilioController < ApplicationController
  def sms
    if request_creator.persist
      render xml: request_creator.message, status: :created
    else
      render xml: { error: request_creator.error }, status: :bad_request
    end
  end

  private

  def twilio_params
    params.permit(
      'SmsMessageSid', 'From', 'Body', 'FromCountry', 'FromState', 'FromCity'
    )
  end

  def request_creator
    @request_creator ||= Request::Creator.new(params: twilio_params)
  end
end
