# frozen_string_literal: true

require 'tomlrb'
require 'thermite/config'

module Thermite
  module Rails
    # A "project" is a crate that contains both Rust and Ruby code. Usually one
    # of these will live at [rails root]/crates/[project].
    class Project
      class OutdatedBuildError < StandardError
        # @param name [String] The crate name.
        def initialize(name)
          msg = "\n\nThermite crate '#{name}' is outdated. To resolve this issue, " \
            "run `rake thermite:build:#{name}` and restart your server.\n\n"

          super(msg)
        end
      end

      attr_reader :project_path, :config

      # @param project_path [String]
      def initialize(project_path)
        @project_path = find_project(project_path)
        @config = Thermite::Config.new(ruby_project_path: @project_path, cargo_project_path: @project_path)
      end

      # @return [String] Path to the project's Cargo.toml file.
      def cargo_toml_path
        File.join(@project_path, 'Cargo.toml')
      end

      # @return [String] Path to the project's Cargo.toml file.
      def gemspec_path
        File.join(@project_path, "#{crate_name}.gemspec")
      end

      def rakefile_path
        File.join(@project_path, 'Rakefile')
      end

      # @return [String] Path to `[project root]/spec/`.
      def spec_path
        File.join(@project_path, 'spec')
      end

      # @return [String] "package.name" from the crate's Cargo.toml file.
      def crate_name
        @crate_name ||= Tomlrb.load_file(cargo_toml_path)['package']['name']
      end

      # @return [Boolean] Does this project have `[project root]/spec/`?
      def specs?
        File.exist?(spec_path)
      end

      # @return [Boolean] Does this project use thermite?
      def thermite?
        return false unless File.exist?(gemspec_path)

        File.read(gemspec_path).include? 'thermite'
      end

      # @return [Boolean] Has the crate been updated since it was last built?
      def outdated_build?
        mtime = Dir["#{@project_path}/src/**/*.rs"].map { |file| File.mtime(file) }.max
        native = "#{@project_path}/lib/#{@config.shared_library}"

        !File.exist?(native) || File.mtime(native) < mtime
      end

      # Raise if the project is outdated.
      def ensure_built!
        raise OutdatedBuildError, crate_name if outdated_build?
      end

      private

      # @param project_path [String]
      def find_project(project_path)
        Thermite::Rails.find_root(project_path) do |dir|
          File.exist?("#{dir}/Cargo.toml")
        end
      end
    end
  end
end
