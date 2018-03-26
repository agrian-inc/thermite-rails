# frozen_string_literal: true

require_relative 'root_project_rake_task'
require_relative 'project_thermite_test_task'

module Thermite
  module Rails
    class RootProjectThermiteTestTask < RootProjectRakeTask
      DESC = 'Using thermite, test all crates'
      NAME = 'thermite:test_all'

      def task_name
        NAME
      end

      def desc_text
        DESC
      end

      def project_task_class
        ProjectThermiteTestTask
      end
    end
  end
end
