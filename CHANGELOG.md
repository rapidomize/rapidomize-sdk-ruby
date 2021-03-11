# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2021-03-11

### Fixed

- `spec.files` did not track all required files, used `git ls-files` to capture
  the list of files to be included in the gem.

## [1.0.0] - 2021-02-20

### Added

- `Payload` class for handling payloads
- `Message` class to send data to the Rapidomize cloud
- `BaseTransport` to enforce an interface on transport classes  
- `CommonHTTP` transport for minimal HTTP transmissions
- SDK specific error classes, under `RapidomizeError`
    - `InvalidPayloadTypeError`
- `JSON` encoding module
- `Client` class to simplify message sending process
- Specs for `Cient`, `Message` and `Payload` classes
- CHANGELOG.md file
    