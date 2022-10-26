# frozen_string_literal: true

module UndriveGoogle
  module Transformations
    #  In Google Doc generated HTML, optionally replace:
    #
    #     <html><head>
    #
    # with
    #
    #     <html lang="en"><head><title>Peter Boling's Bounce to the Ounce</title>
    #
    class FixHtml
      extend Forwardable

      attr_accessor :unzip, :lang, :title

      def_delegator :@unzip, :html_path

      def initialize(unzip)
        @unzip = unzip
        @lang = Options.instance.lang
        @title = Options.instance.title
      end

      # @return nil
      def process
        return unless lang || title

        puts "Checking html in #{html_path}" if Options.instance.verbose
        file = File.open(html_path)
        html = file.read
        return unless html

        puts "Fixing html in #{html_path}" if Options.instance.verbose
        html.sub!("<html>", "<html lang=\"#{lang}\">") if lang
        html.sub!("<head>", "<head><title>#{title}</title>") if title
        File.write(html_path, html)

        nil
      end
    end
  end
end
