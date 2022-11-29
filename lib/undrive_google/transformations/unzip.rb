# frozen_string_literal: true

module UndriveGoogle
  module Transformations
    # Download a particular version of the file.
    class Unzip
      attr_accessor :file_path, :html_path, :destination

      def initialize(file_path, destination = nil)
        @file_path = file_path
        @destination = destination || File.dirname(file_path)
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

      def extract_zip(file, destination)
        Zip::File.open(file) do |zip_file|
          zip_file.each do |f|
            path = File.join(destination, f.name)
            FileUtils.mkdir_p(File.dirname(path))
            zip_file.extract(f, path) unless File.exist?(path)
            @html_path = path if File.extname(path) == ".html"
          end
        end
      end
    end
  end
end
