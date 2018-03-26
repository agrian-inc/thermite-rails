# frozen_string_literal: true

module Thermite
  module Rails
    class ProjectThermiteBuildTask < ProjectRakeTask
      # @return [String]
      def task_name
        "thermite:build:#{crate_name_for_ruby}"
      end

      def define_rake_task
        desc "Using thermite, build crate #{crate_name}"
        task(task_name) do
          load_and { run_task('thermite:build') }
        end
      end
    end
  end
end
