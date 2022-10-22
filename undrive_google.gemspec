# frozen_string_literal: true

require_relative "lib/undrive_google/version"

Gem::Specification.new do |spec|
  spec.name = "undrive_google"
  spec.version = UndriveGoogle::VERSION
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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
