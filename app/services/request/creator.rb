# frozen_string_literal: true

class Request
  class Creator
    PARAMS_MAP = {
      'SmsMessageSid' => :outer_service_id,
      'From' => :phone_number,
      'Body' => :message_content
    }.freeze

    attr_reader :error, :message

    def initialize(params:)
      @params = params
      @error = ''
      @message = ''
    end

    def persist
      if request.save
        @message = twilio_response.to_s
      else
        @error = request.errors.full_messages.join(' ')
      end

      @error.blank?
    end

    private

    attr_reader :params

    def request
      @request ||= Request.new(prepared_params)
    end

    def prepared_params
      params.to_h.each_with_object({}) do |(key, value), memo|
        new_key = PARAMS_MAP[key] || key.underscore
        memo[new_key] = value
        memo
      end
    end

    def twilio_response
      Twilio::TwiML::MessagingResponse.new do |res|
        res.message(
          body: "We received your request: '#{request.message_content.truncate(10)}'. " \
            'Someone should reach out to you shortly.'
        )
      end
    end
  end
end
