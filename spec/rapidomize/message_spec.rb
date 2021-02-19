# frozen_string_literal: true

require 'rspec'
require 'rapidomize'

URI_STRING = 'http://intcon.rapidomize.com'

describe Rapidomize::Message do
  it 'accepts URI as a string' do
    message = described_class.new(URI_STRING)
    expect(message.uri).is_a? URI
  end

  it 'accepts a URI object for URI' do
    message = described_class.new(URI(URI_STRING))
    expect(message.uri).is_a? URI
  end

  it 'accepts an optional payload' do
    payload = Rapidomize::Payload.new.from_hash({ id: 1 })
    message = described_class.new(URI_STRING, payload)
    expect(message.payload).is_a? Rapidomize::Payload
  end
end
