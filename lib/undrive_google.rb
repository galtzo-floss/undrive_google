# frozen_string_literal: true

# Std-lib
require "psych" # The Ruby YAML library
require "singleton" # The Ruby Singleton library

# third party gems
require "version_gem"
require "google_drive"

require_relative "undrive_google/version"

require_relative "undrive_google/actions/download"
require_relative "undrive_google/helpers/parse"
require_relative "undrive_google/captive_file"
require_relative "undrive_google/cli"
require_relative "undrive_google/config_file"
require_relative "undrive_google/options"
require_relative "undrive_google/session"

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
