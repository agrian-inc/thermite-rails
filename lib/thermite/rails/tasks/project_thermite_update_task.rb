# frozen_string_literal: true

require_relative 'project_rake_task'
require_relative '../cargo_runner'

module Thermite
  module Rails
    module Tasks
      class ProjectThermiteUpdateTask < ProjectRakeTask
        # @return [String]
        def task_name
          "thermite:update:#{crate_name_for_ruby}"
        end

        def define_rake_task
          desc "Using thermite, (cargo) update crate #{crate_name}"
          task(task_name) do
            color_puts("Running task: #{task_name}", :blue)

            Thermite::Rails::CargoRunner.new(@project.config).tap do |cargo_runner|
              cargo_runner.run_cargo('update')
            end
          end
        end
      end
    end
  end
end
