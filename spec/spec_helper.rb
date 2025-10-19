# frozen_string_literal: true

# Stdlib
require "logger"

# RSpec Support
require "support/shared_contexts/google_session"
require "support/shared_examples/cli_output"
require "support/rspec_matchers/non_output"

# External RSpec & related config
require "kettle/test/rspec"

# This gem
require "undrive_google"

# RSpec Configs
require "support/rspec_config/reset"
