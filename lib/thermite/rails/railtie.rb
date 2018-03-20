# frozen_string_literal: true

require 'rails/railtie'

module Thermite
  module Rails
    class Railtie < ::Rails::Railtie
      rake_tasks do
        load File.expand_path(File.join('tasks', 'build.rake'), __dir__)
      end
    end
  end
end
