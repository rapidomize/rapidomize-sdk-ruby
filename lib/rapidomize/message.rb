# frozen_string_literal: true

module Rapidomize
  # Message objects are at the core of SDK.
  # Each message is an independent entity with following information
  #
  # * uri, the destination of the message
  # * app_id, ID of the rapidomize app to receive the message
  # * token, For authorizations
  # * payload, actual payload sent to the cloud.
  class Message

    TYPES = %i[session service event icapp ack nak ssm].freeze

    # Initialize a message object
    # @param payload [Payload] a Payload object
    # @param uri [URI, String] optional URI for ICAPPs
    def initialize(payload, uri = nil)
      @payload = payload
      @uri = get_uri(uri)
      @type = guess_type
    end

    # Message type is one of
    # * `:session`
    # * `:service`
    # * `:event`
    # * `:icapp`
    # * `:ack`
    # * `:nak`
    # * `:ssm`
    # Some message types may have special requirements. For example:
    # `:icapp` messages must have a URI corresponding to an ICAPP running
    # on the cloud.
    #
    # @note Currently supports `:icapp` messages only
    attr_reader :type

    # Set message type
    def type=(type)
      raise InvalidMessageType, "Expected one of #{TYPES}, Given: #{type}" unless TYPES.include? type

      @type = type
    end

    private

    def get_uri(uri)
      if uri.is_a? String
        URI(uri)
      else
        uri
      end
    end

    def guess_type
      if @uri.nil?
        :event
      else
        :icapp
      end
    end
  end
end
