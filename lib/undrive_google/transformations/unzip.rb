# frozen_string_literal: true

module UndriveGoogle
  module Transformations
    # Download a particular version of the file.
    class Unzip
      attr_accessor :file_path, :html_path

      def initialize(file_path)
        @file_path = file_path
      end

      # @return nil
      def process
        return unless Options.instance.unzip

        puts "Unzipping #{file_path}" if Options.instance.verbose
        extract_zip(file_path, destination)
        puts "Unzipped #{file_path} to #{html_path}" if Options.instance.verbose

        nil
      end

      private

      def destination
        File.dirname(file_path)
      end

      def extract_zip(file, destination)
        FileUtils.mkdir_p(destination)

        Zip::File.open(file) do |zip_file|
          zip_file.each do |f|
            @html_path = File.join(destination, f.name)
            zip_file.extract(f, @html_path) unless File.exist?(@html_path)
          end
        end
      end
    end
  end
end
