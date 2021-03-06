# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thermite/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'thermite-rails'
  spec.version       = Thermite::Rails::VERSION
  spec.authors       = ['Steve Loveless']
  spec.email         = ['steve@agrian.com']

  spec.summary       = 'Use thermite gems in Rails.'
  spec.description   = spec.summary
  spec.homepage      = 'https://bitbucket.org/agrian/thermite-rails'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 5.0'
  spec.add_dependency 'rake', '>= 10.0'
  spec.add_dependency 'thermite', '~> 0.13'
  spec.add_dependency 'thor'
  spec.add_dependency 'tomlrb', '~> 1.2'

  spec.add_development_dependency 'bundler', '>= 2.2.11'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-checkstyle_formatter'
end
