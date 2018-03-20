# frozen_string_literal: true

require 'colorized_string'
require 'rake/tasklib'
require_relative 'root_project'

module Thermite
  module Rails
    class RootProjectBuildTask < Rake::TaskLib
      def initialize
        define
      end

      def define
        desc 'Build thermite projects in crates'
        task 'thermite:build_all' do
          for_all_projects(&:build)
        end

        desc 'Clean thermite projects in crates'
        task 'thermite:clean_all' do
          for_all_projects(&:clean)
        end
      end

      private

      def root_project
        @root_project ||= Thermite::Rails::RootProject.new(Dir.pwd)
      end

      def for_all_projects
        root_project.projects.each do |project|
          puts '-' * 80
          puts ColorizedString["Building #{project.crate_name}"].colorize(:blue)
          yield(project)
          puts '-' * 80
        end
      end
    end
  end
end
