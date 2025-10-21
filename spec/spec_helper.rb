# frozen_string_literal: true

# Stdlib
require "logger"

# RSpec Support
require "support/shared_contexts/google_session"
require "support/shared_examples/cli_output"
require "support/rspec_matchers/non_output"

# External RSpec & related config
require "kettle/test/rspec"

# NOTE: Gemfiles for older rubies (< 2.7) won't have kettle-soup-cover.
#       The rescue LoadError handles that scenario.
begin
  require "kettle-soup-cover"
  require "simplecov" if Kettle::Soup::Cover::DO_COV # `.simplecov` is run here!
rescue LoadError => error
  # check the error message, and re-raise if not what is expected
  raise error unless error.message.include?("kettle")
end

# This gem
require "undrive_google"

# RSpec Configs
require "support/rspec_config/reset"
