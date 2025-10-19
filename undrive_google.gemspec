# frozen_string_literal: true

require_relative "lib/undrive_google/version"

Gem::Specification.new do |spec|
  # google_drive's epub support is missing, so if you need it, add to your Gemfile:
  #   gem "google_drive", github: "pboling/google-drive-ruby", branch: "pboling-epub-mimetype"
  spec.add_dependency("google_drive", "~> 3.0")
  # rubyzip v3 is unreleased, so add to your Gemfile:
  #   gem "rubyzip", github: "rubyzip/rubyzip", branch: "master"
  # spec.add_dependency("rubyzip", "~> 3.0")
  spec.add_dependency("version_gem", ["~> 1.1", ">= 1.1.1"])

  spec.cert_chain = ["certs/pboling.pem"]
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $PROGRAM_NAME.end_with?("gem")

  spec.name = "undrive_google"
  spec.version = UndriveGoogle::Version::VERSION
  spec.authors = ["Peter Boling"]
  spec.email = ["peter.boling@gmail.com"]

  spec.summary = "🏴 Liberate files from your Google Drive"
  spec.description = "🏴 Liberate files from your Google Drive with transformations"
  spec.homepage = "https://sr.ht/~galtzo/undrive_google/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://git.sr.ht/~galtzo/undrive_google"
  spec.metadata["changelog_uri"] = "https://git.sr.ht/~galtzo/undrive_google"
  spec.metadata["bug_tracker_uri"] = "https://todo.sr.ht/~galtzo/undrive_google"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/#{spec.name}/#{spec.version}"
  spec.metadata["wiki_uri"] = "https://man.sr.ht/~galtzo/undrive_google/"
  spec.metadata["funding_uri"] = "https://liberapay.com/pboling"
  spec.metadata["mailing_list_uri"] = "https://lists.sr.ht/~galtzo/undrive_google-devel"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir[
    "lib/**/*",
    "CHANGELOG.md",
    "CODE_OF_CONDUCT.md",
    "CONTRIBUTING.md",
    "exe/undrive_google",
    "LICENSE.txt",
    "README.md",
    "SECURITY.md",
  ]

  spec.bindir = "exe"
  spec.executables = ["undrive_google"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "kettle-dev", "~> 1.1"
  spec.add_development_dependency "rspec-block_is_expected"
  spec.add_development_dependency "rubocop-lts", "~> 22.0"
end
