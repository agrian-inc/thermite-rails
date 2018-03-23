# frozen_string_literal: true

begin
  require 'rspec/core/rake_task'
  require 'rspec/rails'
rescue LoadError
  return
end

require_relative 'project_rake_task'

module Thermite
  module Rails
    module RakeTaskBuilder
      extend ::Rake::DSL

      def self.define_thermite_spec
        desc 'Run the code examples for all crates'
        RSpec::Core::RakeTask.new('thermite:spec' => 'spec:prepare') do |t|
          t.pattern = 'crates/**/spec/**/*_spec.rb'
        end
      end
    end
  end
end
