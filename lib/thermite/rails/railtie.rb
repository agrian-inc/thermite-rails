# frozen_string_literal: true

require 'rails/railtie'
require_relative 'check_outdated'
require_relative 'root_project'

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
        require_relative 'generators/crate_generator'

      initializer 'thermite.build_check' do |app|
        project = Thermite::Rails::RootProject.new(app.root)

        # This will be added by the install generator, but people may forget to run it
        if ::Rails.env.development? && !config.thermite.key?(:outdated_error)
          config.thermite.outdated_error = :page_load
        end

        if config.thermite.delete(:outdated_error) == :page_load
          config.app_middleware.insert_after ::ActionDispatch::Callbacks,
            Thermite::Rails::CheckOutdated, project
        end
      end
    end
  end
end
