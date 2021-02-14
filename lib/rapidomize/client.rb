# frozen_string_literal: true

module Rapidomize
  # Client
  class Client
    attr_accessor :uri, :transport, :app_id, :token

    def initialize(uri, transport, app_id = nil, token = nil)
      @uri = URI(uri)
      @transport = transport
      @app_id = app_id
      @token = token
    end

    def send(payload)
      pl = Payload.create(payload)
      msg = Message.new(@uri, pl)
      msg.app_id = @app_id unless @app_id.nil?
      msg.token = @token unless  @token.nil?

      @transport.deliver(msg)
    end
  end
end