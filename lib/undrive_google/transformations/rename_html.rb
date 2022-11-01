# frozen_string_literal: true

module UndriveGoogle
  module Transformations
    # Rename the unzipped HTML file.
    class RenameHtml
      extend Forwardable

      attr_accessor :unzip

      def_delegator :@unzip, :html_path

      # @param unzip [UndriveGoogle::Transformations::Unzip]
      def initialize(unzip)
        @unzip = unzip
      end

      # @return nil
      def process
        puts "Renaming html file at #{html_path} to #{rename_path}" if Options.instance.verbose
        File.rename(html_path, rename_path)

        nil
      end

      private

      def rename_path
        "#{File.dirname(html_path)}/#{Options.instance.rename[:html]}"
      end
    end
  end
end
