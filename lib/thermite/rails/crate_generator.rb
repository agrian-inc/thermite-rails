# frozen_string_literal: true

require 'thermite/cargo'
require 'thermite/config'
require_relative 'project'

module Thermite
  module Rails
    class CrateGenerator < ::Rails::Generators::Base
      class CargoRunner
        include Singleton
        include Thermite::Cargo
      end

      namespace 'thermite:crate'
      desc 'add new thermite crate'
      argument :name, type: :string

      def start
        say "Creating crate '#{name}'..."
      end

      def crates_full_path
        @crates_full_path ||= ::Rails.root.join('crates').to_s
      end

      def project_full_path
        @project_full_path ||= File.join(crates_full_path, name)
      end

      def ext_full_path
        @ext_full_path ||= File.join(project_full_path, 'ext')
      end

      def gemspec_full_path
        @gemspec_full_path ||= File.join(project_full_path, "#{name}.gemspec")
      end

      def make_crates_dir
        empty_directory(crates_full_path)
      end

      def run_crate_new_and_bundle_gem
        inside(crates_full_path, verbose: true) do
          run "#{CargoRunner.instance.cargo} new #{name}"
          run "bundle gem #{name}"
        end
      end

      def add_thermite_to_gemspec
        insert_into_file(gemspec_full_path, after: %(  spec.require_paths = ["lib"])) do
          lines = %(\n  spec.extensions << 'ext/Rakefile'\n\n)
          lines + %(  spec.add_runtime_dependency 'thermite', '~> 0')
        end
      end

      def add_ext_directory
        empty_directory(ext_full_path)
      end

      def add_crate_ext_rakefile
        rakefile_path = File.join(ext_full_path, 'Rakefile')

        create_file(rakefile_path) do
          <<~THERM
            require 'thermite/tasks'

            project_dir = File.dirname(File.dirname(__FILE__))
            Thermite::Tasks.new(cargo_project_path: project_dir, ruby_project_path: project_dir)
            task default: %w(thermite:build)
          THERM
        end
      end

      def update_crate_rakefile
        rakefile_path = File.join(project_full_path, 'Rakefile')

        append_to_file rakefile_path do
          %(\nrequire 'thermite/tasks'\n\nThermite::Tasks.new)
        end
      end

      def update_rails_gemfile
        gem name, path: "crates/#{name}"
      end

      def bundle_install
        run 'bundle'
      end
    end
  end
end
