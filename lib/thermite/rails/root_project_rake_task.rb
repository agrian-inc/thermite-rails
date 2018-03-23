# frozen_string_literal: true

require 'colorized_string'
require 'rake/tasklib'
require_relative 'root_project'

module Thermite
  module Rails
    class RootProjectRakeTask < Rake::TaskLib
      def initialize
        @root_project = Thermite::Rails.root_project
      end

      def task_name
        raise 'Define in child'
      end

      def project_task_class
        raise 'Define in child'
      end

      def define_rake_task
        desc
        task task_name => project_task_names
      end

      def define_project_rake_tasks
        project_tasks.each(&:define_rake_task)
      end

      # @return [Array<String>]
      def project_task_names
        project_tasks.map(&:task_name)
      end

      def project_tasks
        @project_tasks ||= @root_project.projects.map do |project|
          project_task_class.new(project)
        end
      end
    end
  end
end
