# frozen_string_literal: true

require_relative 'root_project_rake_task'
require_relative 'project_thermite_build_task'

module Thermite
  module Rails
    module Tasks
      class RootProjectThermiteBuildTask < RootProjectRakeTask
        DESC = 'Using thermite, build all crates'
        NAME = 'thermite:build_all'

        def task_name
          NAME
        end

        def desc_text
          DESC
        end

        def project_task_class
          ProjectThermiteBuildTask
        end
      end
    end
  end
end
