# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

# Dummy apps don't get a Gemfile. Since thermite-rails has code for updating a
# Gemfile, we should test that that works, thus we need to eval in the dummy
# app's Gemfile to pick up the crates.
eval_gemfile 'spec/dummy/Gemfile'
