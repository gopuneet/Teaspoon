
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teaspoon/version'

Gem::Specification.new do |spec|
  spec.name          = 'teaspoon'
  spec.version       = Teaspoon::VERSION
  spec.authors       = ['Daniel Giralt']
  spec.email         = ['daniel.giralt.len@gmail.com']

  spec.summary       = 'Saves execution data of cucumber over time.'
  spec.description   = 'Saves execution data of cucumber over time.'
  spec.homepage      = ''

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this
  # section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = '\'http://mygemserver.com\''
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_dependency 'dotenv', '~> 2.2.1'
  spec.add_dependency 'mysql'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'redis', '~> 3.2'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
