# frozen_string_literal: true

module Thermite
  module Rails
    class ProjectThermiteTestTask < ProjectRakeTask
      def task_name
        "thermite:test:#{crate_name_for_ruby}"
      end

      def define_rake_task
        desc "Using thermite, (cargo) test crate #{crate_name}"
        task(task_name) do
          load_and { run_task('thermite:test') }
        end
      end
    end
  end
end
