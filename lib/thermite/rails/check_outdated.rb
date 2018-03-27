# frozen_string_literal: true

module Thermite
  module Rails
    # Rack middleware for ensuring projects have been built.
    class CheckOutdated
      def initialize(app, project)
        @app = app
        @project = project
        @last_check = 0
      end

      def call(env)
        @project.ensure_built!
        @app.call(env)
      end
    end
  end
end
