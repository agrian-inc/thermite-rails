# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/tasks/project_spec_task'
require 'thermite/rails/tasks/project_thermite_build_task'

RSpec.describe Thermite::Rails::Tasks::ProjectSpecTask do
  let(:project_path) { Thermite::Rails::Project.new(::Rails.root.join('crates', 'test_crate').to_s) }
  subject { described_class.new(project_path) }

  describe '#task_name' do
    specify { expect(subject.task_name).to eq('spec:crates:test_crate') }
  end

  describe '#define_rake_task' do
    it 'makes a Rake task with the name #task_name' do
      subject.define_rake_task

      expect(Rake::Task.task_defined?('spec:crates:test_crate')).to eq(true)

      task = Rake::Task['spec:crates:test_crate']
      expect(task.prerequisites).to eq(%w[thermite:build:test_crate])
    end
  end
end
