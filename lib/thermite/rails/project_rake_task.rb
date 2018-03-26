# frozen_string_literal: true

require 'rake/tasklib'
require 'thor/shell/color'

module Thermite
  module Rails
    class ProjectRakeTask < ::Rake::TaskLib
      delegate :crate_name, :project_path, to: :@project

      # @param project [Thermite::Rails::Project]
      def initialize(project)
        @project = project
        @shell = Thor::Shell::Color.new
      end

      # @param [String]
      def crate_name_for_ruby
        crate_name.underscore
      end

      # @param [String]
      def task_name
        raise 'Define in child'
      end

      def define_rake_task
        raise 'Define in child'
      end

      # @param message [String]
      # @param color Whatever is supported by highline.
      def color_puts(message, color = :blue)
        @shell.say "[#{crate_name}] #{message}", color
      end

      private

      def load_and
        Dir.chdir(project_path) do
          load_rakefile do
            yield
          end
        end
      end

      def load_rakefile
        load 'Rakefile'
        yield
      rescue LoadError => ex
        color_puts("Skipping due to LoadError: #{ex.message}", :red)
      end

      # @param task_name [String]
      def run_task(task_name)
        color_puts("Running task: #{task_name}", :blue)

        Rake::Task[task_name].invoke
      rescue RuntimeError => ex
        if ex.message.match?("Don't know how to build task '#{task_name}'")
          color_puts("No Rake task '#{task_name}'; skipping", :yellow)
        else
          abort ex.message
        end
      end
    end
  end
end
