# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/tasks/root_project_thermite_test_task'

RSpec.describe Thermite::Rails::Tasks::RootProjectThermiteTestTask do
  describe '#task_name' do
    specify { expect(subject.task_name).to eq('thermite:test_all') }
  end
end
