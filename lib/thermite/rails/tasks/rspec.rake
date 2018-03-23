# frozen_string_literal: true

projects_with_specs = Thermite::Rails.root_project.projects_with_specs

return if projects_with_specs.empty?

require_relative '../root_project_spec_task'

Thermite::Rails::RootProjectSpecTask.new.tap do |builder|
  builder.define_project_rake_tasks
  builder.define_rake_task
end
