# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/tasks/project_thermite_clean_task'

RSpec.describe Thermite::Rails::Tasks::ProjectThermiteCleanTask do
  subject do
    proj = Thermite::Rails::Project.new(::Rails.root.join('crates', 'test_crate').to_s)
    described_class.new(proj)
  end

  describe '#task_name' do
    specify { expect(subject.task_name).to eq('thermite:clean:test_crate') }
  end

  describe '#define_rake_task' do
    it 'makes a Rake task with the name #task_name' do
      subject.define_rake_task

      expect(Rake::Task.task_defined?('thermite:clean:test_crate')).to eq(true)

      task = Rake::Task['thermite:clean:test_crate']
      expect(task.prerequisites).to eq([])
    end
  end
end
