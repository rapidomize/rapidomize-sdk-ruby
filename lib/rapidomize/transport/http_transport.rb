# frozen_string_literal: true

module Rapidomize
  module Transports
    # CommonHTTP transport is used to send payloads via HTTP protocol
    # It is called common http, since it does not maintain a persistent
    # connection with a server.
    # For CommonHTTP to send data, messages must provide a valid URI
    # of the HTTP endpoint.
    class CommonHTTP < BaseTransport
      include Retryable

      # Deliver a message to the URI of the message
      # @param message [Message] a message object with a URI
      # @return [Net::HTTPResponse] Response object for the deliver
      def deliver(message)
        # TODO: Add support for other HTTP verbs too. (i.e PUT, GET, UPDATE)
        headers = {
          'Content-Type' => 'application/json'
        }
        Net::HTTP.post message.uri,
                       message.payload.to_json,
                       headers
      end
    end
  end
end
