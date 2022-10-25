# frozen_string_literal: true

module UndriveGoogle
  module Actions
    # Download a particular version of the file.
    class Download
      attr_accessor :file, :extension, :dir

      def initialize(extension)
        @file = Session.instance.file
        @extension = extension.to_s
        @dir = Options.instance.dir
      end

      def download!
        puts "Downloading #{file.title} as: #{extension} to: #{dir}/#{name}" if Options.instance.verbose
        file.export_as_file("#{dir}/#{name}", extension)
      end

      private

      def name
        "#{rename}.#{extension}"
      end

      def rename
        exact_name = Options.instance.rename[extension]
        return exact_name if exact_name

        Options.instance.rename_proc.call(file.title)
      end
    end
  end
end
