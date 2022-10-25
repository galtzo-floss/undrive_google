# frozen_string_literal: true

module UndriveGoogle
  # Represents the YAML config file for this gem
  class ConfigFile
    DEFAULT = {}.freeze

    attr_accessor :args

    def initialize(path)
      @args = config_file(path)

      validate(@args)

      return if @args == DEFAULT

      rename_keys = (@args.keys - [:rename_pattern]).select { |k| k.start_with?("rename") }
      if rename_keys.any?
        @args[:rename] = rename_keys.each_with_object({}) do |k, rename|
          key = k.to_s.sub("rename_", "")
          rename[key.to_sym] = @args.delete(k.to_sym)
        end
      end
      @args[:extensions] = Helpers::Parse.extensions(@args[:extensions]) if key?(:extensions)
      rename_pattern = @args.delete(:rename_pattern)
      @args[:rename_proc] = Helpers::Parse.rename_proc(rename_pattern) if rename_pattern
    end

    def [](val)
      args[val]
    end

    def key?(k)
      args.key?(k)
    end

    def any?
      args.keys.any?
    end

    private

    def config_file(path)
      return DEFAULT unless File.exist?(path)

      Psych.load_file(path, symbolize_names: true, fallback: DEFAULT)
    end

    def validate(config)
      unknown = config.keys - YAML_KEYS
      unknown.reject! { |key| key.start_with?("rename") }
      return if unknown.empty?

      raise UndriveGoogle::Error, "Unhandled config keys #{unknown.inspect}"
    end
  end
end
