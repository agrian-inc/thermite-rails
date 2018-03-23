# frozen_string_literal: true

begin
  require 'rspec/core/rake_task'
  require 'rspec/rails'
rescue LoadError
  return
end

require_relative 'root_project_rake_task'
require_relative 'project_spec_task'

module Thermite
  module Rails
    class RootProjectSpecTask < RootProjectRakeTask
      DESC = 'Run code examples for all crates'
      NAME = 'spec:crates'

      def task_name
        NAME
      end

      def desc
        super(DESC)
      end

      def project_task_class
        ProjectSpecTask
      end

      def project_tasks
        @project_tasks ||= @root_project.projects_with_specs.map do |project|
          project_task_class.new(project)
        end
      end
    end
  end
end
