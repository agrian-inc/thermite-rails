# frozen_string_literal: true

require_relative 'root_project_rake_task'
require_relative 'project_thermite_update_task'

module Thermite
  module Rails
    module Tasks
      class RootProjectThermiteUpdateTask < RootProjectRakeTask
        DESC = 'Using thermite, (cargo) update all crates'
        NAME = 'thermite:update_all'

        def task_name
          NAME
        end

        def desc_text
          DESC
        end

        def project_task_class
          ProjectThermiteUpdateTask
        end
      end
    end
  end
end
