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
    class ProjectSpecTask < ProjectRakeTask
      # @return [String]
      def task_name
        "spec:crates:#{crate_name_for_ruby}"
      end

      def define_rake_task
        desc "Run the code examples in #{crate_name}"
        RSpec::Core::RakeTask.new(task_name => ["thermite:build:#{crate_name_for_ruby}", 'spec:prepare']) do |t|
          t.pattern = "#{@project.spec_path}/**/*_spec.rb"
        end
      end
    end
  end
end
