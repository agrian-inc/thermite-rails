# frozen_string_literal: true

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

load 'spec/dummy/Rakefile'
RSpec::Core::RakeTask.new spec: %w[thermite:test_all]
