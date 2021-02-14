# frozen_string_literal: true

module Rapidomize
  module Transports
    # Interface for Transport classes to implement
    class BaseTransport
      # Method to invoke to send a message to the URI of the message
      # @param _message [Message] a message object with a URI, *IGNORED* on BaseTransport
      # @raise NotImplementedError on BaseTransport objects
      def deliver(_message)
        raise NotImplementedError
      end

      # Method to invoke when a message is received from the cloud
      # @raise NotImplementedError on BaseTransport objects
      def receive
        raise NotImplementedError
      end
    end
  end
end
