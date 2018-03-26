# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TestCrate do
  it 'has a version number' do
    expect(TestCrate::VERSION).not_to be nil
  end
end
