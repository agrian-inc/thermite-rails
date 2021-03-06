
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_crate/version'

Gem::Specification.new do |spec|
  spec.name          = 'test_crate'
  spec.version       = TestCrate::VERSION
  spec.authors       = ['Steve Loveless']
  spec.email         = ['steve@agrian.com']

  spec.summary       = 'Part of my thermite-rails dummy app.'
  spec.description   = spec.summary
  spec.homepage      = 'https://bitbucket.org/agrian/thermite-rails'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'meow'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions << 'ext/Rakefile'

  spec.add_runtime_dependency 'thermite', '~> 0'

  spec.add_development_dependency 'bundler', '>= 2.2.11'
  spec.add_development_dependency 'rake', '>= 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
