# frozen_string_literal: true

require 'rspec'
require 'rapidomize'

require_relative '../spec_webmock_helper'

CONNECT_TO = 'http://intcon.rapidomize.com/api'

describe Rapidomize::Client do
  before do
    stub_request(:post, CONNECT_TO)
      .with(body: /.*/, headers: { 'Content-Type' => 'application/json' })
      .to_return(status: 200, body: '', headers: {})
  end

  it 'accepts a URI string' do
    transport = Rapidomize::Transports::CommonHTTP.new
    client = described_class.new(CONNECT_TO, transport)
    expect(client.uri).is_a? URI
  end

  it 'sends the payload with the given transport' do
    transport = Rapidomize::Transports::CommonHTTP.new
    client = described_class.new(CONNECT_TO, transport)
    response = client.send({ id: 1 })
    expect(response.code).to eq('200')
  end
end
