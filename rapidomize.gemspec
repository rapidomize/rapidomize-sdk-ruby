# frozen_string_literal: true

require_relative 'lib/rapidomize/version'

Gem::Specification.new do |spec|
  spec.name          = 'rapidomize'
  spec.version       = Rapidomize::VERSION
  spec.authors       = ['Nisal Bandara']
  spec.email         = ['nisal.bandara@outlook.com']
  spec.licenses      = ['Apache-2.0']

  spec.summary       = 'Rapidomize Ruby SDK'
  spec.description   = 'Connect to Rapidomize cloud with Ruby'
  spec.homepage      = 'https://rapidomize.github.io/rapidomize-ruby-sdk'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rapidomize/rapidomize-ruby-sdk'
  spec.metadata['changelog_uri'] = 'https://github.com/rapidomize/rapidomize-ruby-sdk/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'asciidoctor', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.9'
  spec.add_development_dependency 'rubocop-rake', '~> 0.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.2'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.add_development_dependency 'yard', '~> 0.9'
end
