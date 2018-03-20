# frozen_string_literal: true

require 'colorized_string'
require 'tomlrb'

module Thermite
  module Rails
    # A crate that contains both Rust and Ruby code.
    class Project
      def initialize(root_path)
        @root_path = find_root(root_path)
        puts "Project@root_path: #{@root_path}"
      end

      def crate_name
        @crate_name ||= Tomlrb.load_file(cargo_toml_path)['package']['name']
      end

      def build
        Dir.chdir(@root_path) do
          load_rakefile do
            remove_old_binary
            run_thermite_build
          end
        end
      end

      def clean
        Dir.chdir(@root_path) do
          load_rakefile do
            remove_old_binary
            run_thermite_clean
          end
        end
      end

      private

      def find_root(root_path)
        Thermite::Rails.find_root(root_path) do |dir|
          File.exist?("#{dir}/Cargo.toml")
        end
      end

      def cargo_toml_path
        "#{@root_path}/Cargo.toml"
      end

      def load_rakefile
        load 'Rakefile'
        yield
      rescue LoadError => ex
        puts ColorizedString["Skipping due to LoadError: #{ex.message}"].colorize(:red)
      end

      def remove_old_binary
        puts ColorizedString['Removing old Rust binary...'].colorize(:blue)

        FileUtils.rm_f("#{@root_path}/lib/*.so")
      end

      def run_thermite_build
        run_thermite_task('thermite:build')
      end

      def run_thermite_clean
        run_thermite_task('thermite:clean')
      end

      def run_thermite_task(task_name)
        Rake::Task[task_name].invoke
      rescue RuntimeError => ex
        puts ex
        if ex.message.match?("Don't know how to build task '#{task_name}'")
          # puts ColorizedString["#{crate_name} isn't using thermite; trying `rake build`..."].colorize(:yellow)
          # Rake::Task['build'].invoke
        else
          abort ex.message
        end
      end
    end
  end
end
