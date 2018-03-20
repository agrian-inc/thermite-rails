# frozen_string_literal: true

require_relative 'project'

module Thermite
  module Rails
    class RootProject
      def initialize(root_path)
        @root_path = find_root(root_path)
        puts "RootProject@root_path: #{@root_path}"
      end

      def projects
        @projects ||= Dir["#{@root_path}/crates/*"].
                      find_all { |f| File.exist?("#{f}/Cargo.toml") }.
                      map { |d| Thermite::Rails::Project.new(d) }
      end

      private

      def find_root(root_path)
        Thermite::Rails.find_root(root_path) do |dir|
          !Dir["#{dir}/{Gemfile,*.gemspec}"].empty?
        end
      end
    end
  end
end
