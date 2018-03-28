# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/tasks/root_project_thermite_build_task'

RSpec.describe Thermite::Rails::Tasks::RootProjectThermiteBuildTask do
  describe '#task_name' do
    specify { expect(subject.task_name).to eq('thermite:build_all') }
  end
end
