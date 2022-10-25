# frozen_string_literal: true

SimpleCov.start do
  enable_coverage :branch
  primary_coverage :branch
  add_filter "spec"
  add_filter "sig"
  add_filter "lib/undrive_google/version.rb"
  add_filter "exe/undrive_google"
  track_files "**/*.rb"
  if ALL_FORMATTERS
    command_name "#{ENV.fetch("GITHUB_WORKFLOW",
                              nil)} Job #{ENV.fetch("GITHUB_RUN_ID",
                                                    nil)}:#{ENV.fetch("GITHUB_RUN_NUMBER",
                                                                      nil)}"
  else
    formatter SimpleCov::Formatter::HTMLFormatter
  end
  minimum_coverage(line: 100, branch: 100)
end
