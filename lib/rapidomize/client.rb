# frozen_string_literal: true

module Rapidomize
  # A client object is a simplification of the message sending
  # process. It merely abstract the Message creation process by
  # automatically creating messages and assign payloads and URIs
  # to them. A transport method is still needed for the delivery
  # process.
  class Client
    attr_accessor :uri, :transport, :app_id, :token

    # Create a new client with a URI and a transport method. These
    # parameters will be used with every payload sent through this
    # client.
    # @param uri [String] URI for all payloads sent through this client.
    # @param transport [Rapidomize::Transports::BaseTransport] mode of transport.
    #   Must be a subclass of BaseTransport
    # @param app_id [String] _(optional)_ Application id for the messages.
    # @param token [String] _(optional)_ Token for message authorization.
    def initialize(uri, transport, app_id = nil, token = nil)
      @uri = URI(uri)
      @transport = transport
      @app_id = app_id
      @token = token
    end

    # Send the payload
    # @param payload [Hash, String, Payload] payload data to send
    # @return [Net::HTTPResponse] return the response object
    def send(payload)
      pl = Payload.create(payload)
      msg = Message.new(@uri, pl)
      msg.app_id = @app_id unless @app_id.nil?
      msg.token = @token unless @token.nil?

      @transport.deliver(msg)
    end
  end
end
