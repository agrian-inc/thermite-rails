# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dummy::Application do
  describe 'Thermite::Rails.root_proejct' do
    it 'is the path to this app' do
      expect(Thermite::Rails.root_project.path).to eq(Thermite::Rails::RootProject.new(Rails.root).path)
    end
  end
end
