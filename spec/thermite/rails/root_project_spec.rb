# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thermite::Rails::RootProject do
  subject { described_class.new(::Rails.root.to_s) }

  describe '#projects' do
    it 'returns crates/* as Project objects' do
      actual_crate_names = subject.projects.map(&:crate_name)
      expected_crate_names = [Thermite::Rails::Project.new(Rails.root.join('crates', 'test_crate'))].map(&:crate_name)

      expect(actual_crate_names).to eq(expected_crate_names)
    end
  end

  describe '#projects_with_specs' do
    it 'returns crates/* as Project objects' do
      actual_crate_names = subject.projects_with_specs.map(&:crate_name)
      expected_crate_names = [Thermite::Rails::Project.new(Rails.root.join('crates', 'test_crate'))].map(&:crate_name)

      expect(actual_crate_names).to eq(expected_crate_names)
    end
  end
end
