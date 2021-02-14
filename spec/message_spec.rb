require 'rspec'
require 'rapidomize'

URI_STRING = 'http://intcon.rapidomize.com'.freeze

describe Rapidomize::Message do
  it 'has the destination as a URI' do
    message_string_uri = Rapidomize::Message.new(URI_STRING)
    expect(message_string_uri.uri).is_a? URI

    message_uri_uri = Rapidomize::Message.new(URI(URI_STRING))
    expect(message_uri_uri.uri).is_a? URI
  end

  it 'has an optional payload' do
    payload = Rapidomize::Payload.new.from_hash({ id: 1 })
    message = Rapidomize::Message.new(URI_STRING, payload)
    expect(message.payload).to eq(payload)
  end
end
