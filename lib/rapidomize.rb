# frozen_string_literal: true

require 'json' # for #to_json
require 'uri'

# Errors
require 'rapidomize/error/rapidomize_error'
require 'rapidomize/error/invalid_payload_type_error'
require 'rapidomize/error/invalid_message_type'

# Utilities
require 'rapidomize/encoding/json'

# APIs
require 'rapidomize/message'
require 'rapidomize/payload'
