# frozen_string_literal: true

module Rapidomize
  # Payload objects are used to manage the payloads exchanged between
  # Rapidomize Cloud and SDK. Payload objects can encode or decode their
  # state to or from custom formats. (JSON, msgpack, ...).
  #
  # There are two kinds of payload objects:
  #
  # *Hash-like* payloads collects payload information in key-value pairs.
  #
  # *Enum-like* payloads collects information as an array of Hash-like payloads.
  # Useful when sending multiple payloads in one request. This type of payloads
  # are immutable.
  class Payload
    include Enumerable

    private

    # Get the internal hash object.
    def hashmap
      raise InvalidPayloadTypeError, 'Cannot use Enum-like payload as Hash-like' unless @type == :hash || @type.nil?

      @type = :hash
      @hashmap ||= {}
    end

    # Get the internal array object
    def collection
      raise InvalidPayloadTypeError, 'Cannot use Hash-like payload as Enum-like' unless @type == :enum || @type.nil?

      @type = :enum
      @collection ||= []
    end

    public

    # Factory method create payloads from other data types. This method
    # will return corresponding Payload objects for Hashes, JSON strings.
    # If the given object is already a Payload, it will be copied.
    # It returns an empty Payload when obj is nil
    # @param [Hash, String, Payload, nil] obj A hash, possible JSON string or a Payload object
    # @return a Payload object
    # @raise ArgumentError if obj is not a Hash, String, Payload or nil
    def self.create(obj)
      return Payload.new if obj.nil?

      case obj
      when Hash
        # noinspection RubyYardParamTypeMatch
        Payload.new.from_hash(obj)
      when String
        # noinspection RubyYardParamTypeMatch
        Payload.new.from_json(obj)
      when Payload
        obj.clone
      else
        raise ArgumentError, "Expected Hash, String or Payload; Given: #{obj.class}"
      end
    end

    # Get a value from the payload
    # @param key A key to search in the payload
    # @return the value associated with payload key, nil if key is not in payload
    def [](key)
      hashmap[key.to_s]
    end

    # Set a value in the payload
    # @param key A key to search in the payload
    # @param value to be set for the key
    # @return the value
    def []=(key, value)
      hashmap[key.to_s] = value
    end

    # Check if the key exists in the payload
    # @param key The key to search in the payload
    # @return true if payload includes `key`
    def has?(key)
      hashmap.include? key.to_s
    end

    # Set values from a hash object
    # @param hash [Hash] Hash to include data from
    def from_hash(hash)
      hashmap.merge!(hash.transform_keys(&:to_s))
      self
    end

    # Add a payload to the collection
    # @param payload [Payload] A payload to add
    # @return [Payload] added payload
    def <<(payload)
      if payload.is_a? Array
        payload.each do |elem|
          raise InvalidPayloadTypeError, "Expected: Payload, Given: #{payload.class}" unless elem.is_a? Payload

          collection << elem
        end
      else
        raise InvalidPayloadTypeError, "Expected: Payload, Given: #{payload.class}" unless payload.is_a? Payload

        collection << payload
      end
      payload
    end

    # Return the size of the payload collection
    # @return the size of the payload collection
    def size
      data.size
    end

    # Each method for enumerable features
    def each(&block)
      if @type == :enum
        collection.each { |payload| block.call(payload) }
      else
        hashmap.each { |key, value| block.call(key, value) }
      end
    end

    def data
      if @type == :enum
        collection.clone
      else
        hashmap.clone
      end
    end

    include Encoding::Json
  end
end
