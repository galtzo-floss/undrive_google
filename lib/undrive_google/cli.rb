# frozen_string_literal: true

module UndriveGoogle
  # Defines the CLI behavior & provides the Google Drive Session
  class CLI
    include Singleton

    attr_reader :parser, :options, :session

    # Options specified on the command line are collected in *@options*.
    #
    # @param [ARGV] args
    # @return nil
    def parse(args)
      @options = Options.instance
      @parser = OptionParser.new do |parser|
        @options.define_options(parser)
        parser.parse!(args)
      end
      raise UndriveGoogle::Error, "file_id is required!" unless options.file_id
      raise UndriveGoogle::Error, "dir is required!" unless options.dir

      @session = Session.instance

      nil
    end

    def liberate!
      Options.instance.title = session.file.title if missing_title?
      CaptiveFile.instance.liberate!
    end

    private

    def missing_title?
      Options.instance.title.nil? || Options.instance.title.empty?
    end
  end
end
