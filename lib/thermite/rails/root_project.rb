# frozen_string_literal: true

require_relative 'project'

module Thermite
  module Rails
    class RootProject
      attr_reader :path

      def initialize(path)
        @path = find_root(path)
      end

      def projects
        @projects ||= Dir["#{@path}/crates/*"].
                      find_all { |f| File.exist?("#{f}/Cargo.toml") }.
                      find_all { |f| File.exist?("#{f}/Cargo.toml") }.
                      map { |d| Thermite::Rails::Project.new(d) }.
                      find_all(&:thermite?)
      end

      def projects_with_specs
        projects.find_all(&:specs?)
      end

      private

      def find_root(path)
        Thermite::Rails.find_root(path) do |dir|
          !Dir["#{dir}/{Gemfile,*.gemspec}"].empty?
        end
      end
    end
  end
end
