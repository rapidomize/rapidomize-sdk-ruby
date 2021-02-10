# frozen_string_literal: true

module Rapidomize
  # Message objects are at the core of SDK.
  # Each message is an independent entity with following information
  #
  # uri:: A message must have a URI, which is the destination of the message.
  # payload:: _(optional)_ A message may contain a Payload to transmit data
  # token:: _(optional)_ token for authorization purposes
  # app_id:: _(optional)_ app_id of the receiving ICAPP
  class Message
    TYPES = %i[session service event icapp ack nak ssm].freeze

    attr_reader :uri, :payload, :app_id, :token

    # Initialize a message object
    # @param uri [URI, String] Destination of the message.
    # @param payload [Hash, String, Payload] Payload to transmit.
    # @param token [String] Authorization token
    # @param app_id [String] Receiving app id
    def initialize(uri, payload = nil, token = nil, app_id = nil)
      raise ArgumentError, 'uri is nil' if uri.nil?

      @payload = Payload.create(payload) unless payload.nil?
      @uri = sanitize_uri(uri)
      @app_id = app_id
      @token = token
      @type = guess_type
    end

    # Type of the message.
    # One of
    #
    # * `:session`
    # * `:service`
    # * `:event`
    # * `:icapp`
    # * `:ack`
    # * `:nak`
    # * `:ssm`
    attr_reader :type

    # Set message type
    def type=(type)
      raise InvalidMessageType, "Expected one of #{TYPES}, Given: #{type}" unless TYPES.include? type

      @type = type
    end

    private

    # sanitize URIs.
    # TODO: make sure the given URI is a valid rapidomize URL
    def sanitize_uri(uri)
      if uri.is_a? String
        URI(uri)
      else
        uri
      end
    end

    # Try to infer the type of the message.
    # TODO: implement type inference
    def guess_type
      :icapp
    end
  end
end
