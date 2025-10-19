# frozen_string_literal: true

module UndriveGoogle
  # A file on Google Drive
  class CaptiveFile
    include Singleton

    attr_accessor :options, :exports

    # @return nil
    def liberate!
      sweep! if Options.instance.sweep
      @exports = []
      extensions.each do |format|
        liberate = Actions::Liberate.new(format)
        @exports << liberate.file_path
        liberate.liberate!
      end

      nil
    end

    private

    def sweep!
      sweep = Actions::Sweep.new
      sweep.sweep!
    end

    def extensions
      Options.instance.extensions
    end
  end
end
