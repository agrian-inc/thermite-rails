# frozen_string_literal: true

require_relative 'project'

module Thermite
  module Rails
    # A root project is really just the Rails project, which can have a number of
    # nested "projects" under crates/[project name].
    class RootProject
      attr_reader :path

      # @param path [String]
      def initialize(path)
        @path = find_root(path)
      end

      # @return [Array<Thermite::Rails::Project>]
      def projects
        @projects ||= Dir["#{@path}/crates/*"].
                      find_all { |f| File.exist?("#{f}/Cargo.toml") }.
                      find_all { |f| File.exist?("#{f}/Cargo.toml") }.
                      map { |d| Thermite::Rails::Project.new(d) }.
                      find_all(&:thermite?)
      end

      # @return [Array<Thermite::Rails::Project>]
      def projects_with_specs
        projects.find_all(&:specs?)
      end

      def ensure_built!
        projects.each(&:ensure_built!)
      end

      private

      # @param path [String]
      # @return [String]
      def find_root(path)
        Thermite::Rails.find_root(path) do |dir|
          !Dir["#{dir}/{Gemfile,*.gemspec}"].empty?
        end
      end
    end
  end
end
