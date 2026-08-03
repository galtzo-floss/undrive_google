# frozen_string_literal: true

require "anonymous_loader"
require "undrive_google"
RSpec.describe UndriveGoogle::Version do
  it_behaves_like "a Version module", described_class

  it "executes the version file for coverage without redefining constants" do
    paths = [
      File.expand_path("../../lib/undrive_google/version.rb", __dir__),
      File.expand_path("../../lib/undrive_google/version_gem.rb", __dir__)
    ].select { |path| File.file?(path) }
    anonymous_namespace = AnonymousLoader.load(files: paths)

    expect(anonymous_namespace::UndriveGoogle::Version::VERSION).to eq(described_class::VERSION)
  end
end
