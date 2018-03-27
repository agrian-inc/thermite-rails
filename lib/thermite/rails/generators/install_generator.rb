# frozen_string_literal: true

module Thermite
  module Rails
    class InstallGenerator < ::Rails::Generators::Base
      namespace 'thermite:install'
      desc 'install thermite'

      def configure_environment
        environment 'config.thermite.outdated_error = :page_load', env: :development
      end
    end
  end
end
