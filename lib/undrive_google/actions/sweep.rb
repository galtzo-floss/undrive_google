# frozen_string_literal: true

module UndriveGoogle
  module Actions
    # Empty the directory before putting liberated files into it?
    class Sweep
      attr_accessor :dir

      def initialize
        @dir = Options.instance.dir
      end

      def sweep!
        return if !dir || dir.length.zero? || dir == "/"
        return unless Dir.exist?(dir)
        return if Dir.empty?(dir)

        puts "Sweeping directory clean #{dir}" if Options.instance.verbose
        FileUtils.rm_rf(Dir.glob("#{dir}/*"))
      end
    end
  end
end
