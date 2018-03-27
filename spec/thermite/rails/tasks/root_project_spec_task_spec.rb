# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/tasks/root_project_spec_task'

RSpec.describe Thermite::Rails::Tasks::RootProjectSpecTask do
  describe '#task_name' do
    specify { expect(subject.task_name).to eq('spec:crates') }
  end

  describe '#define_rake_task' do
    it 'makes a Rake task with the name #task_name' do
      subject.define_rake_task
      expect(Rake::Task.task_defined?('spec:crates')).to eq(true)

      task = Rake::Task['spec:crates']
      expect(task.prerequisites).to eq(%w[spec:crates:test_crate])
    end
  end
end
