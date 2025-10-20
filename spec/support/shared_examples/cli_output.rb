# frozen_string_literal: true

RSpec.shared_examples_for "cli output" do |expected|
  it "is printed" do
    skip_for(engine: :jruby, reason: "output capturing not supported on JRuby")
    block_is_expected.to not_output.to_stderr_from_any_process &
      output(a_string_including(expected)).to_stdout_from_any_process
  end
end
