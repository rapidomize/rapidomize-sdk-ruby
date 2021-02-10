# frozen_string_literal: true

module Rapidomize
  module Encoding
    # Encode payload to JSON and build payload from JSON
    module Json
      # Encode the payload object in JSON
      # @param args same as Ruby JSON.generate
      # @return [String] a JSON string
      def to_json(*args)
        data.to_json(*args)
      end

      # Add to Payload from a JSON string
      # @example From a json array, build an enum-like payload
      #   json_string = " '[{"data":1},{"data": 2}]'
      #   payload = Rapidomize::Payload.new.from_json(json_string)
      # This can also be used to add data from JSON strings
      # @param str [String] A valid JSON string
      # @return [Payload] self
      def from_json(str)
        json = JSON.parse(str)
        if json.is_a? Array
          json.each do |j|
            self << Rapidomize::Payload.new.from_hash(j)
          end
        else
          from_hash(json)
        end
        self
      end
    end
  end
end
