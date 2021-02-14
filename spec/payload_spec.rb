# frozen_string_literal: true

require 'rspec'
require 'rapidomize'

describe Rapidomize::Payload do
  it 'initializes an empty payload' do
    payload = Rapidomize::Payload.new
    expect(payload.size).to eq(0)
  end

  it 'gives nil for non-existent keys' do
    payload = Rapidomize::Payload.new
    value = payload[:nonkey]
    expect(value).to be_nil
  end

  it 'can take key-value pairs' do
    payload = Rapidomize::Payload.new
    payload[:key] = 'value'
    expect(payload.size).to eq(1)
    expect(payload[:key]).to eq('value')
  end

  it 'can create payloads from hashes' do
    payload = Rapidomize::Payload.new.from_hash({ id: 1, data: 2 })
    expect(payload.size).to eq(2)
    expect(payload[:id]).to eq(1)
  end

  it 'converts all keys to strings' do
    payload = Rapidomize::Payload.new.from_hash({ id: 1, data: 2 })
    expect(payload['id']).to_not be_nil
  end

  it 'acts as a collection of Payloads' do
    payload_child1 = Rapidomize::Payload.new.from_hash({ id: 1 })
    payload_child2 = Rapidomize::Payload.new.from_hash({ id: 2 })
    payload_parent = Rapidomize::Payload.new
    payload_parent << [payload_child1, payload_child2]
    expect(payload_parent.size).to eq(2)
  end

  it 'raises Exception if tried to add a non-payload object' do
    payload = Rapidomize::Payload.new
    expect do
      payload << 1
    end.to raise_error(Rapidomize::InvalidPayloadTypeError)

    expect do
      payload << [Rapidomize::Payload.new, 1]
    end.to raise_error(Rapidomize::InvalidPayloadTypeError)
  end

  it 'can generate JSON representation of itself' do
    json_actual = Rapidomize::Payload.new.from_hash({ id: 1 }).to_json
    json_expected = '{"id":1}'
    expect(json_expected).to eq(json_actual)
  end

  it 'can build itself from a JSON representation' do
    payload = Rapidomize::Payload.new.from_json('{"id":1}')
    payload.from_json('{"from":"json"}') # add to the existing payload from json

    expect(payload['id']).to eq(1)
    expect(payload['from']).to eq('json')
  end
end
