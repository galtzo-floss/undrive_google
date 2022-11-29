# frozen_string_literal: true

module UndriveGoogle
  module Actions
    # Liberate a file, and transform it
    class Liberate
      extend Forwardable

      attr_accessor :extension, :tr, :dir, :file, :file_path

      def_delegator :@tr, :download
      def_delegator :@tr, :unzip
      def_delegator :@tr, :rename_html
      def_delegator :@tr, :fix_html
      def_delegator :@tr, :delete_zip
      def_delegator :@tr, :liberate!

      def initialize(extension)
        @extension = extension.to_s
        @file = Session.instance.file
        @dir = Options.instance.dir
        @file_path = "#{@dir}/#{name}"
        @tr = Transformation.new(download: Transformations::Download.new(@file_path, @extension))
        return unless zip?

        if Options.instance.unzip
          @tr.unzip = Transformations::Unzip.new(@file_path)
          @tr.fix_html = Transformations::FixHtml.new(@tr.unzip) if Options.instance.lang || Options.instance.title
          @tr.rename_html = Transformations::RenameHtml.new(@tr.unzip) if Options.instance.rename[:html]
        end

        @tr.delete_zip = Transformations::DeleteZip.new(@file_path) unless Options.instance.keep_zip
      end

      private

      def name
        "#{rename}.#{extension}"
      end

      def rename
        exact_name = Options.instance.rename[extension]
        return exact_name if exact_name
        return file.title unless Options.instance.rename_proc

        Options.instance.rename[extension] = Options.instance.rename_proc.call(file.title)
      end

      # The zip is an HTML file packaged in a .zip archive
      def zip?
        extension == "zip"
      end
    end
  end
end
