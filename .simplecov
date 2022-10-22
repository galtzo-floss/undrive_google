# frozen_string_literal: true

SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch
  add_filter "spec"
  add_filter "sig"
  add_filter "lib/undrive_google/version.rb"
  add_filter "exe/undrive_google"
  track_files "**/*.rb"
  formatter SimpleCov::Formatter::HTMLFormatter
  minimum_coverage(line: 100, branch: 100)
end
