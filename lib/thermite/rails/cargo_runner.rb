# frozen_string_literal: true

require 'thermite/cargo'

module Thermite
  module Rails
    # Just a wrapper object for thermite's {{Thermite::Cargo}} module.
    class CargoRunner
      include Thermite::Cargo
      include FileUtils

      attr_reader :config

      # @param config [Thermite::Config]
      def initialize(config)
        @config = config
      end
    end
  end
end
