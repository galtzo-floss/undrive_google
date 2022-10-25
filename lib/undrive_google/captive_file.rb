# frozen_string_literal: true

module UndriveGoogle
  # A file on Google Drive
  class CaptiveFile
    include Singleton
    attr_accessor :options, :exports

    # @return nil
    def liberate!
      @exports = []
      extensions.each do |format|
        download = Actions::Download.new(format)
        exports << download
        download.download!
      end

      nil
    end

    private

    def extensions
      Options.instance.extensions
    end
  end
end
