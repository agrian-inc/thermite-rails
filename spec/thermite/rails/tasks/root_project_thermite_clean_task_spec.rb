# frozen_string_literal: true

require 'rails_helper'
require 'thermite/rails/tasks/root_project_thermite_clean_task'

RSpec.describe Thermite::Rails::Tasks::RootProjectThermiteCleanTask do
  describe '#task_name' do
    specify { expect(subject.task_name).to eq('thermite:clean_all') }
  end
end
