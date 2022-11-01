# frozen_string_literal: true

module UndriveGoogle
  # Combine defaults with YAML and CLI provided options
  class Options
    include Singleton

    attr_accessor :config_yaml, :key_file, :file_id, :file_by, :extensions, :unzip,
                  :keep_zip, :rename, :rename_proc, :lang, :title,
                  :dir, :sweep, :verbose

    def initialize
      load_yaml(true)
    end

    def define_options(parser)
      parser.banner = "Usage: undrive_google [options]"
      parser.separator ""

      # Handle YAML, as default overrides
      config_yaml_option(parser)

      # ARGV will override the defaults and YAML values
      key_file_option(parser)
      file_id_option(parser)
      by_option(parser)
      extensions_option(parser)
      unzip_option(parser)
      keep_zip_option(parser)
      rename_options(parser)
      dir_option(parser)
      lang_option(parser)
      title_option(parser)
      sweep_option(parser)
      verbose_option(parser)

      parser.separator ""

      # Print an options summary.
      parser.on_tail("-h", "--help", "Show this message") do
        puts parser
        exit
      end
    end

    private

    # CLI options will take precedence over values in YAML
    def config_yaml_option(parser)
      parser.on("-c", "--config-yaml PATH", String,
                "Path to UndriveGoogle config YAML file") do |config_yaml|
        self.config_yaml = config_yaml
        load_yaml
      end
    end

    def key_file_option(parser)
      parser.on("-k", "--key-file PATH", String,
                "Path to Google Service Account Keys JSON file") do |key_file|
        self.key_file = key_file
      end
    end

    def file_id_option(parser)
      parser.on("-i", "--file-id ID", String,
                "ID used to find file (key or title)") do |file_id|
        self.file_id = file_id
      end
    end

    def by_option(parser)
      parser.on("-b", "--file-by [TYPE]", %i[key title],
                "Select type of ID used to find file (key, title)") do |file_by|
        self.file_by = file_by
      end
    end

    def extensions_option(parser)
      # List of arguments.
      parser.on("-e", "--extensions x,y,z", Array, "Formats to liberate (export/download)") do |extensions|
        self.extensions = Helpers::Parse.extensions(extensions)
      end
    end

    def unzip_option(parser)
      # Boolean switch.
      parser.on("-u", "--[no-]unzip", "Unzip liberated .zip") do |unzip|
        self.unzip = unzip
      end
    end

    def keep_zip_option(parser)
      # Boolean switch.
      parser.on("-z", "--[no-]keep-zip", "Keep liberated .zip after unzipping") do |keep_zip|
        self.keep_zip = keep_zip
      end
    end

    def rename_options(parser)
      ALL_FILE_TYPES.each do |ft|
        parser.on("--rename-#{ft} [FILENAME]", "Rename #{ft} to FILENAME") do |rename|
          self.rename[ft] = rename
        end
      end
      parser.on("--rename-pattern pattern,replace", Array, "Rename other files with gsub(pattern, replace)") do |arr|
        self.rename_proc = Helpers::Parse.rename_proc(arr)
      end
    end

    def dir_option(parser)
      parser.on("-d", "--dir PATH", String,
                "Path to directory where liberated files will go") do |dir|
        self.dir = dir.strip
      end
    end

    def lang_option(parser)
      parser.on("-l", "--lang LANG", String, 'Add lang="LANG" attribute to <html> tag of unzipped HTML') do |lang|
        self.lang = lang.strip
      end
    end

    def title_option(parser)
      parser.on("-t", "--title TITLE", String, "Add <title>TITLE</title> element to unzipped HTML") do |title|
        self.title = title.strip
      end
    end

    def sweep_option(parser)
      # Boolean switch.
      parser.on("-s", "--[no-]sweep",
                "Delete all files from directory specified by -d or --dir prior to liberation") do |sweep|
        self.sweep = sweep
      end
    end

    def verbose_option(parser)
      # Boolean switch.
      parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        self.verbose = v
      end
    end

    def load_yaml(reset = false)
      if reset
        self.config_yaml = CONFIG_YAML_PATH
        self.key_file = KEY_FILE_PATH
        self.file_id = nil
        self.file_by = :key
        self.extensions = DL_FILE_TYPES # "all" expands to FILE_TYPES
        self.unzip = true
        self.keep_zip = true
        self.rename = {}
        self.rename_proc = RENAME_PROC
        self.title = nil
        self.dir = nil
        self.lang = "en"
        self.sweep = false
        self.verbose = false
      end

      cf = ConfigFile.new(config_yaml)
      return unless cf.any?

      (YAML_KEYS - [:rename_pattern]).each do |key|
        send("#{key}=", cf[key]) if cf.key?(key)
      end
      self.rename = cf[:rename] if cf.key?(:rename)
      self.rename_proc = cf[:rename_proc] if cf.key?(:rename_proc)
    end
  end
end
