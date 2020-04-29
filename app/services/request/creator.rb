# frozen_string_literal: true

class Request
  class Creator
    REQUEST_ENUMS = { sms: 0, voice: 1 }.freeze
    PARAMS_MAP = {
      'SmsMessageSid' => :outer_service_id,
      'CallSid' => :outer_service_id,
      'From' => :phone_number,
      'Body' => :message_content
    }.freeze
    REQUEST_RECEIVED_MESSAGE = 'We received your request. Someone should reach out to you shortly.'

    attr_reader :error, :message

    def initialize(params:)
      @params = params
      @voice_request = params['CallSid'].present?
      @error = ''
      @message = ''
      perform_validation
    end

    def persist
      return false if @error.present?

      if request.save
        @message = twilio_response.to_s
      else
        @error = request.errors.full_messages.join(' ')
      end

      @error.blank?
    end

    private

    attr_reader :params, :voice_request

    def perform_validation
      add_double_id_error
    end

    def add_double_id_error
      return unless params['CallSid'].present? && params['SmsMessageSid'].present?

      @error += 'Both Call ID and Message ID were specified.'
    end

    def request
      @request ||= Request.new(prepared_params.merge(reception_type: reception_type))
    end

    def prepared_params
      params.to_h.each_with_object({}) do |(key, value), memo|
        new_key = PARAMS_MAP[key] || key.underscore
        memo[new_key] = value if value.present?
        memo
      end
    end

    def reception_type
      voice_request ? REQUEST_ENUMS[:voice] : REQUEST_ENUMS[:sms]
    end

    def twilio_response
      voice_request ? voice_response : sms_response
    end

    # :reek:UtilityFunction { enabled: false }
    def sms_response
      Twilio::TwiML::MessagingResponse.new do |res|
        res.message(body: REQUEST_RECEIVED_MESSAGE)
      end
    end

    # :reek:UtilityFunction { enabled: false }
    def voice_response
      Twilio::TwiML::VoiceResponse.new do |res|
        res.say(body: REQUEST_RECEIVED_MESSAGE)
      end
    end
  end
end
