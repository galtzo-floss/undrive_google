# frozen_string_literal: true

# third party gems
require "version_gem"

require_relative "undrive_google/version"
require_relative "undrive_google/cli"

module UndriveGoogle
  class Error < StandardError; end
end

UndriveGoogle::Version.class_eval do
  extend VersionGem::Basic
end
