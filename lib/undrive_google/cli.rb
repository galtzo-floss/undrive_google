# frozen_string_literal: true

module UndriveGoogle
  # Defines the CLI behavior
  class CLI
    attr_accessor :options

    def initialize(options)
      @options = options.dup
    end
  end
end
