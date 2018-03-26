# frozen_string_literal: true

require_relative 'rails/version'
require_relative 'rails/railtie'

module Thermite
  module Rails
    # @param root_path [String]
    # @return [String] Path to the root of the (Rails) project.
    def self.find_root(root_path)
      root = File.expand_path(root_path)

      dir = root

      loop do
        return dir if yield(dir)

        new_dir = File.dirname(dir)
        raise "Unable to find root for #{root}" if new_dir == dir

        dir = new_dir
      end
    end

    # @return [Thermite::Rails::RootProject]
    def self.root_project
      require_relative 'rails/root_project'
      @root_project ||= Thermite::Rails::RootProject.new(::Rails.root.to_s)
    end
  end
end
