# frozen_string_literal: true

source "https://gem.coop"

git_source(:gitlab) { |repo_name| "https://gitlab.com/#{repo_name}" }
git_source(:codeberg) { |repo_name| "https://codeberg.org/#{repo_name}" }

eval_gemfile "gemfiles/modular/debug.gemfile"
eval_gemfile "gemfiles/modular/coverage.gemfile"
eval_gemfile "gemfiles/modular/style.gemfile"
eval_gemfile "gemfiles/modular/documentation.gemfile"
eval_gemfile "gemfiles/modular/optional.gemfile"
eval_gemfile "gemfiles/modular/x_std_libs.gemfile"

# Specify your gem's dependencies in undrive_google.gemspec
gemspec

# See: https://github.com/gimite/google-drive-ruby/pull/427
gem "google_drive", github: "pboling/google-drive-ruby", branch: "pboling-epub-mimetype"

gem "rubyzip", "~> 3.2"

# ex std-lib
gem "logger"
