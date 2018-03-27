# frozen_string_literal: true

require_relative 'root_project_thermite_build_task'
require_relative 'root_project_thermite_clean_task'
require_relative 'root_project_thermite_test_task'

[
  Thermite::Rails::Tasks::RootProjectThermiteBuildTask,
  Thermite::Rails::Tasks::RootProjectThermiteCleanTask,
  Thermite::Rails::Tasks::RootProjectThermiteTestTask
].each do |task_class|
  task_class.new.tap do |builder|
    builder.define_project_rake_tasks
    builder.define_rake_task
  end
end
