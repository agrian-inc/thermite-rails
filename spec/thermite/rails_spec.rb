# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Thermite::Rails do
  it 'has a version number' do
    expect(Thermite::Rails::VERSION).not_to be nil
  end
end
