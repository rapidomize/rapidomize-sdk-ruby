# Rapidomize

This is the Ruby version of Rapidomize SDK.

## Getting Started

### Installation

You can install Rapidomize from gem tool,

```shell
gem install rapidomize
```

or by adding to the Gemfile

```ruby
gem 'rapidomize'
```

### Usage

The most basic usage for the SDK would be a sending a JSON payload to the 
Rapidomize cloud using a webhook. This is a simple task with the 
`Rapidomize::Client` class.

```ruby
require 'rapidomize'

# create a transport for HTTP 
http_transport = Rapidomize::Transports::CommonHTTP.new

# create a client with the webhook string
webhook = "https://rapidomize.com/api/webhook/string"
rpz = Rapidomize::Client.new(webhook, http_transport)

# send a simple payload (as a Hash object)
res = rpz.send({ message: 'This is a test', time: Time.now })

# Client#send returns a Net::HTTTPResponse object.
puts res.code
```

## Concepts

There are three basic concepts in this SDK. 
1. Payloads
2. Messages
3. Transports

### Payloads

Payloads are the data being sent to the cloud. Payloads can
be serialized to and deserialize from various data formats.

> **SDK v1.0**: only supported (de)serialization format is JSON.

A payload object has two structures, depending on the type of
data it holds. And one payload has only one structure.

#### Hash-like Payloads

This type of payloads are essentially hash objects. This is the
most basic structure for a payload. They hold data as 
key-value pairs, just like in a ruby hash. 

Example:
```ruby
# keys can be any type, with a to_s method 
payload[:id] = 'value'
# all keys are converted to strings internally
puts payload['id'] # => value
```

A payload is Hash-like if,
1. created from a hash (`Rapidomize::Payload.new.from_hash`)
2. created from a JSON string containing a JSON object
3. `#[]`  operator is used (possibly before `#<<` operator)

#### Enum-like payloads

Sometimes it may be required to send multiple payloads in a 
single message. But messages accepts only one payload object.
In these situations, we can use enum-like structure of the
Payload. `<<` operator can insert a Payload object into 
another Payload.

```ruby
payload_collection = Rapidomize::Payload.new

# to be inserted in to collection
payload_1 = Rapidomize::Payload.new.from_hash({ id: 1 })

# insert a single payload
payload_collection << payload_1

payload_2 = Rapidomize::Payload.new.from_hash({ id: 2 })
payload_3 = Rapidomize::Payload.new.from_hash({ id: 3 })

# << can take arrays of payload
payload_collection << [payload_2, payload_3]
# each payload in the array is inserted to the collection
# separately, so payload_collection is similar to
# [{id: 1}, {id: 2}, {id: 3}]
```

A payload is Enum-like, if
1. created from a JSON string containing a JSON array
2. `#<<` operator is used (possibly before `#[]` operator)

Enum-like payloads are `Enumerable` 

### Messages

A message is like an envelop to send a payload. It has a 
destination URI, an application id and a token to be used
when sending the payload on a transport. 

A message must have a destination URI. Application id and 
token are optional.

### Transports

Transports are how the data is transmitted to the cloud.
HTTP, MQTT, WebSockets are the example modes for transports.

Each transport class will implement the necessary mechanism
to send (and receive, if needed) the data to the cloud.


