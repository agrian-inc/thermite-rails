# frozen_string_literal: true

require 'tomlrb'

module Thermite
  module Rails
    # A "project" is a crate that contains both Rust and Ruby code. Usually one
    # of these will live at [rails root]/crates/[project].
    class Project
      attr_reader :project_path

      # @param project_path [String]
      def initialize(project_path)
        @project_path = find_project(project_path)
      end

      # @return [String] Path to the project's Cargo.toml file.
      def cargo_toml_path
        "#{@project_path}/Cargo.toml"
      end

      # @return [String] "package.name" from the crate's Cargo.toml file.
      def crate_name
        @crate_name ||= Tomlrb.load_file(cargo_toml_path)['package']['name']
      end

      # @return [Boolean] Does this project have `[project root]/spec/`?
      def specs?
        File.exist?(spec_path)
      end

      # @return [String] Path to `[project root]/spec/`.
      def spec_path
        "#{@project_path}/spec"
      end

      private

      def find_project(project_path)
        Thermite::Rails.find_root(project_path) do |dir|
          File.exist?("#{dir}/Cargo.toml")
        end
      end
    end
  end
end
