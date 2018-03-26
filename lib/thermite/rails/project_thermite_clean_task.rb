# frozen_string_literal: true

require_relative 'project_rake_task'

module Thermite
  module Rails
    class ProjectThermiteCleanTask < ProjectRakeTask
      # @return [String]
      def task_name
        "thermite:clean:#{crate_name_for_ruby}"
      end

      def define_rake_task
        desc "Using thermite, clean crate #{crate_name}"
        task(task_name) { run_task('thermite:clean') }
      end
    end
  end
end
