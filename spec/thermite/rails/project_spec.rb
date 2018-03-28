# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thermite::Rails::Project do
  describe 'attrs' do
    it { is_expected.to respond_to(:project_path) }
    it { is_expected.to respond_to(:config) }
  end

  let(:thermite_project_path) { Rails.root.join('crates', 'test_crate') }
  subject(:thermite_project) { described_class.new(thermite_project_path) }

  let(:no_thermite_project_path) { Rails.root.join('crates', 'no_thermite') }
  subject(:no_thermite_project) { described_class.new(no_thermite_project_path) }

  describe '#cargo_toml_path' do
    context 'crate uses thermite' do
      it 'returns the full path to the file' do
        result = thermite_project.cargo_toml_path
        expect(Pathname.new(result)).to be_absolute
        expect(result).to match(%r{crates/test_crate/Cargo.toml})
      end
    end
  end

  describe '#gemspec_path' do
    context 'crate uses thermite' do
      it 'returns the full path to the file' do
        result = thermite_project.gemspec_path
        expect(Pathname.new(result)).to be_absolute
        expect(result).to match(%r{crates/test_crate/test_crate.gemspec})
      end
    end
  end

  describe '#rakefile_path' do
    context 'crate uses thermite' do
      it 'returns the full path to the file' do
        result = thermite_project.rakefile_path
        expect(Pathname.new(result)).to be_absolute
        expect(result).to match(%r{crates/test_crate/Rakefile})
      end
    end
  end

  describe '#spec_path' do
    context 'crate uses thermite' do
      it 'returns the full path to the directory' do
        result = thermite_project.spec_path
        expect(Pathname.new(result)).to be_absolute
        expect(result).to match(%r{crates/test_crate/spec})
      end
    end
  end

  describe '#specs?' do
    context 'crate has specs' do
      specify { expect(thermite_project.specs?).to eq(true) }
    end

    context 'crate does not have specs' do
      specify { expect(no_thermite_project.specs?).to eq(false) }
    end
  end

  describe '#thermite?' do
    context 'crate uses thermite' do
      specify { expect(thermite_project.thermite?).to eq(true) }
    end

    context 'crate does not use thermite' do
      specify { expect(no_thermite_project.thermite?).to eq(false) }
    end
  end
end
