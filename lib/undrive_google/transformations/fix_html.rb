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

      # @param unzip [UndriveGoogle::Transformations::Unzip]
      def initialize(unzip)
        @unzip = unzip
        @lang = Options.instance.lang
        @title = Options.instance.title
      end

      # @return nil
      def process
        return unless lang_valid? || title_valid?
        raise UndriveGoogle::Error, "No file at #{html_path}" unless File.exist?(html_path)

        puts "Checking html in #{html_path}" if Options.instance.verbose
        file = File.open(html_path)
        html = file.read
        return unless html.length >= 12 # open & close <html> or <head> is at least 12 chars

        puts "Fixing html in #{html_path}" if Options.instance.verbose
        html.sub!("<html>", "<html lang=\"#{lang}\">") if lang_valid?
        html.sub!("<head>", "<head><title>#{title}</title>") if title_valid?
        File.write(html_path, html)

        nil
      end

      def lang_valid?
        lang && lang.length >= 2
      end

      def title_valid?
        title && title.length >= 1
      end
    end
  end
end
