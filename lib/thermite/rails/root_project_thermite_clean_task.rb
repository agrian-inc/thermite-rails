# frozen_string_literal: true

require_relative 'root_project_rake_task'
require_relative 'project_thermite_clean_task'

module Thermite
  module Rails
    class RootProjectThermiteCleanTask < RootProjectRakeTask
      DESC = 'Using thermite, clean all crates'
      NAME = 'thermite:clean_all'

      def task_name
        NAME
      end

      def desc
        super(DESC)
      end

      def project_task_class
        ProjectThermiteCleanTask
      end
    end
  end
end
