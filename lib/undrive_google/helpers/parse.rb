# frozen_string_literal: true

module UndriveGoogle
  module Helpers
    # Config Parsing Helpers
    module Parse
      module_function

      def extensions(val)
        if val.is_a?(Array)
          unknown = val.map(&:to_sym) - FILE_TYPES
          raise UndriveGoogle::Error, "Unknown extensions: #{unknown}" if unknown.any?

          val
        elsif val == "all"
          FILE_TYPES
        elsif FILE_TYPES.include?(val.to_sym)
          [val]
        else
          raise UndriveGoogle::Error, "Unknown extensions: #{val}"
        end
      end

      def rename_proc(val)
        raise UndriveGoogle::Error, "invalid rename pattern #{val}" unless val.length == 2

        pattern = Regexp.new(val[0])
        replace = val[1]
        ->(orig) { orig.gsub(pattern, replace) }
      end
    end
  end
end
