# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/root_project_thermite_test_task'

RSpec.describe Thermite::Rails::RootProjectThermiteTestTask do
  describe '#task_name' do
    specify { expect(subject.task_name).to eq('thermite:test_all') }
  end
end
