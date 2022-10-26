# frozen_string_literal: true

module UndriveGoogle
  module Transformations
    # Download a particular version of the file.
    class Download
      attr_accessor :file, :extension, :file_path

      def initialize(file_path, extension)
        @extension = extension
        @file = Session.instance.file
        @file_path = file_path
      end

      # @return nil
      def process
        puts "Downloading #{file.title} as: #{extension} to: #{file_path}" if Options.instance.verbose
        file.export_as_file(file_path, extension)

        nil
      end
    end
  end
end
