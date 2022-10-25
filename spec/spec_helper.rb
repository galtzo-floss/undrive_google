# frozen_string_literal: true

# Stdlib

ALL_FORMATTERS = ENV.fetch("COVER_ALL") { ENV.fetch("CI_CODECOV") { ENV.fetch("CI", nil) } }

# RSpec Support
require "support/shared_contexts/google_session"
require "support/shared_examples/cli_output"
require "support/rspec_matchers/non_output"

# Third party libs
require "rspec/block_is_expected"
require "version_gem/rspec"
require "byebug"
require "simplecov" # Config file `.simplecov` is run immediately when simplecov loads
require "codecov"
require "simplecov-json"
require "simplecov-lcov"
require "simplecov-cobertura"

# This will override the formatter set in .simplecov
if ALL_FORMATTERS
  SimpleCov::Formatter::LcovFormatter.config do |c|
    c.report_with_single_file = true
    c.single_report_path = "coverage/lcov.info"
  end

  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::CoberturaFormatter, # XML for Jenkins
    SimpleCov::Formatter::LcovFormatter,
    SimpleCov::Formatter::JSONFormatter, # For CodeClimate
    SimpleCov::Formatter::Codecov # For CodeCov
  ]
end

# This gem
require "undrive_google"

# RSpec Configs
require "support/rspec_config/core"
