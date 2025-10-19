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

  spec.add_development_dependency("kettle-dev", "~> 1.1")                     # ruby >= 2.3.0
  spec.add_development_dependency("bundler-audit", "~> 0.9.2")                      # ruby >= 2.0.0

  spec.add_development_dependency("rake", "~> 13.0")                                # ruby >= 2.2.0

  spec.add_development_dependency("require_bench", "~> 1.0", ">= 1.0.4")            # ruby >= 2.2.0

  spec.add_development_dependency("appraisal2", "~> 3.0")                           # ruby >= 1.8.7, for testing against multiple versions of dependencies

  spec.add_development_dependency("kettle-test", "~> 1.0")                          # ruby >= 2.3

  spec.add_development_dependency("rspec-pending_for", "~> 0.0", ">= 0.0.17")       # ruby >= 2.3, used to skip specs on incompatible Rubies

  spec.add_development_dependency("ruby-progressbar", "~> 1.13")                    # ruby >= 0

  spec.add_development_dependency("stone_checksums", "~> 1.0", ">= 1.0.2")          # ruby >= 2.2.0

  # spec.add_development_dependency("erb", ">= 2.2")                                  # ruby >= 2.3.0, not SemVer, old rubies get dropped in a patch.

  spec.add_development_dependency("gitmoji-regex", "~> 1.0", ">= 1.0.3")            # ruby >= 2.3.0

  # spec.add_development_dependency("backports", "~> 3.25", ">= 3.25.1")  # ruby >= 0

  # spec.add_development_dependency("vcr", ">= 4")                        # 6.0 claims to support ruby >= 2.3, but fails on ruby 2.4

  # spec.add_development_dependency("webmock", ">= 3")                    # Last version to support ruby >= 2.3

  spec.add_development_dependency("rubocop-lts", "~> 22.0")
end
