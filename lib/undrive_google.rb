# frozen_string_literal: true

# Std-lib
require "psych" # The Ruby YAML library
require "forwardable" # The Ruby Delegation library
require "singleton" # The Ruby Singleton library

# third party gems
begin
  require "zip"
rescue LoadError
  warn "[WARN] Failed to load gem rubyzip, so unzip (and thus html) options will not work."
end
require "version_gem"
require "google_drive"
gd_fixed = GoogleDrive::Util::EXT_TO_CONTENT_TYPE.key?('.epub')
warn "[WARN] Your version of google_drive does not support .epub. If you need .epub support see: https://sr.ht/~galtzo/undrive_google/#note-export-epub" unless gd_fixed

require_relative "undrive_google/version"

require_relative "undrive_google/helpers/parse"
require_relative "undrive_google/actions/liberate"
require_relative "undrive_google/transformations/delete_zip"
require_relative "undrive_google/transformations/download"
require_relative "undrive_google/transformations/fix_html"
require_relative "undrive_google/transformations/rename_html"
require_relative "undrive_google/transformations/unzip"
require_relative "undrive_google/captive_file"
require_relative "undrive_google/cli"
require_relative "undrive_google/config_file"
require_relative "undrive_google/options"
require_relative "undrive_google/session"
require_relative "undrive_google/transformation"

module UndriveGoogle
  class Error < StandardError; end

  FILE_BY = {
    title: :title,
    key: :key
  }.freeze
  FILE_TYPES = %i[docx odt rtf pdf txt zip epub].freeze
  RENAME_PROC = ->(orig) { orig.tr(" ", "_") }
  YAML_KEYS = %i[
    key_file
    file_id
    file_by
    extensions
    unzip
    keep_zip
    rename_pattern
    title
    dir
    lang
    verbose
  ].freeze
  CONFIG_YAML_PATH = "undrive_google.yaml"
  KEY_FILE_PATH = "service_account_private_key.json"
end

UndriveGoogle::Version.class_eval do
  extend VersionGem::Basic
end
