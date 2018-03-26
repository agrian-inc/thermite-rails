# frozen_string_literal: true

source 'https://rubygems.org'

# Declare your gem's dependencies in thermite-rails.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]

# Dummy apps don't get a Gemfile. Since thermite-rails has code for updating a
# Gemfile, we should test that that works, thus we need to eval in the dummy
# app's Gemfile to pick up the crates.
eval_gemfile 'spec/dummy/Gemfile'
