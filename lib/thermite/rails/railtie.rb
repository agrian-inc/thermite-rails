# frozen_string_literal: true

require 'rails/railtie'

module Thermite
  module Rails
    class Railtie < ::Rails::Railtie
      config.thermite = ActiveSupport::OrderedOptions.new

      rake_tasks do
        if ::Rails.env.development? && defined?(::RSpec)
          load File.expand_path(File.join('tasks', 'rspec.rake'), __dir__)
        end

        load File.expand_path(File.join('tasks', 'thermite.rake'), __dir__)
      end

      generators do
        require_relative 'crate_generator'
      end
    end
  end
end
