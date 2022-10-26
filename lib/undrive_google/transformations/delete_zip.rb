# frozen_string_literal: true

module UndriveGoogle
  module Transformations
    # Delete the downloaded zip file.
    class DeleteZip
      attr_accessor :file_path

      def initialize(file_path)
        @file_path = file_path
      end

      # @return nil
      def process
        puts "Deleting #{file_path}" if Options.instance.verbose
        File.delete(file_path)

        nil
      end
    end
  end
end
