# frozen_string_literal: true

require 'rake/tasklib'

module Thermite
  module Rails
    module Tasks
      # This is intended as a base class for defining other Rake tasks at the
      # Rails/root project level (as opposed to the crate/project level).
      class RootProjectRakeTask < ::Rake::TaskLib
        def initialize
          @root_project = Thermite::Rails.root_project
        end

        # @return [String]
        def task_name
          raise 'Define in child'
        end

        # @return [Class]
        def project_task_class
          raise 'Define in child'
        end

        # Text the task should list for its `desc`.
        #
        # @return [String]
        def desc_text
          raise 'Define in child'
        end

        # Method that does the standard Rake task DSL calls for defining the task.
        def define_rake_task
          return if Rake::Task.task_defined?(task_name)

          desc(desc_text)
          task task_name => prerequisite_tasks
        end

        # A list of all of the tasks this take should run.
        #
        # @return [Array<String>]
        def prerequisite_tasks
          project_task_names
        end

        # Iterates through each project task and calls `#define_rake_task`.
        def define_project_rake_tasks
          project_tasks.each(&:define_rake_task)
        end

        # @return [Array<String>]
        def project_task_names
          project_tasks.map(&:task_name)
        end

        # @return [Array<Class>]
        def project_tasks
          @project_tasks ||= @root_project.projects.map do |project|
            p = project_task_class.new(project)
            p.define_rake_task unless p.defined?

            p
          end
        end

        # @return [Boolean] Has a task with this name already been defined?
        def defined?
          Rake::Task.task_defined?(task_name)
        end
      end
    end
  end
end
