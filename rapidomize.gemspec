# frozen_string_literal: true

require_relative 'lib/rapidomize/version'

Gem::Specification.new do |spec|
  spec.name          = 'rapidomize'
  spec.version       = Rapidomize::VERSION
  spec.authors       = ['Nisal Bandara']
  spec.email         = ['nisal.bandara@outlook.com']

  spec.summary       = 'Rapidomize Ruby SDK'
  spec.description   = 'Connect to Rapidomize cloud with Ruby'
  spec.homepage      = 'https://github.com/rapidomize/rapidomize-ruby-sdk'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files = Dir.chdir(File.expand_path(__dir__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  # end
  spec.files = %w[lib/rapidomize.rb lib/rapidomize]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'asciidoctor', '~> 2.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 1.9'
  spec.add_development_dependency 'yard', '~> 0.9'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
