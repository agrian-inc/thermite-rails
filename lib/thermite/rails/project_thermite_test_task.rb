# frozen_string_literal: true

require_relative 'project_rake_task'

module Thermite
  module Rails
    class ProjectThermiteTestTask < ProjectRakeTask
      # @return [String]
      def task_name
        "thermite:test:#{crate_name_for_ruby}"
      end

      def define_rake_task
        desc "Using thermite, (cargo) test crate #{crate_name}"
        task(task_name) { run_task('thermite:test') }
      end
    end
  end
end
