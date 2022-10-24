# frozen_string_literal: true

# Third party libs
require "rspec/block_is_expected"
require "version_gem/rspec"

# This gem
require "undrive_google"

RSpec::Matchers.define_negated_matcher :not_output, :output
RSpec.shared_examples_for "cli output" do |expected|
  it "is printed" do
    block_is_expected.to not_output.to_stderr_from_any_process &
                         output(a_string_including(expected)).to_stdout_from_any_process
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
