# frozen_string_literal: true

RSpec.describe "UnDrive Google CLI" do
  subject(:cli) { system("./exe/undrive_google #{args}") }

  let(:args) { options.map { |(k, v)| "--#{k} #{v}" }.join(" ") }

  context "with --help" do
    let(:options) { {help: nil} }

    it_behaves_like "cli output", <<~BANNER
      Usage: undrive_google [options]
    BANNER
  end
end
