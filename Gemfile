# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in undrive_google.gemspec
gemspec

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }
git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }

gem "byebug"

# See: https://github.com/gimite/google-drive-ruby/pull/427
gem "google_drive", github: "pboling/google-drive-ruby", branch: "pboling-epub-mimetype"

gem "rubyzip", "~> 3.2"

gem "rake", "~> 13.0"
gem "rspec", "~> 3.0"
gem "rubocop-md", "~> 1.1"
gem "rubocop-packaging"
gem "rubocop-performance"
gem "rubocop-rake"
gem "rubocop-rspec"

gem "codecov" # For CodeCov
gem "simplecov", require: false
gem "simplecov-cobertura" # XML for Jenkins
gem "simplecov-json" # For CodeClimate
gem "simplecov-lcov", require: false

# ex std-lib
gem "logger"
