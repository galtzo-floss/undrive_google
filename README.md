# UndriveGoogle

Toolkit for:
1. Liberating variously formatted files from your Google Drive
2. Applying a set of transformations to liberated files
    * patterned rename
    * unzip
    * correct HTML errors
3. Profit

Want to link directly to the Google-Drive-hosted alternate format of a file?
If yes, DO NOT use this gem. Instead follow [these instructions](https://support.google.com/a/users/answer/9308985?hl=en).

OTOH, if you want to "own", host, track, etc your 'own' files
(e.g. your resume), DO use this gem.

## NOTE: Export epub

There is a bug (missing feature) in `google_drive` gem preventing export of epub.  You can use this patched branch:

```ruby
gem "google_drive", github: "pboling/google-drive-ruby", branch: "pboling-epub-mimetype"
```

And you can upvote this PR [#427](https://github.com/gimite/google-drive-ruby/pull/427).

## Story Time

Imagine Google Drive is a 🐭
Imagine your file (e.g. resume) is a 🍪
🐭's 🍪 exporter: 🖨

Tell me if you've heard this one already.

1. Give 🐭 your 🍪 for "safe-keeping"
2. Recognizing this SPoF, you ask 🐭 to give back a 🍪 copy
3. "I'll run it through my 🍪 🖨", says 🐭
4. 🖨 replicates various 🍪 extensions: `pdf`, `odt`, `docx`, `txt`, `rtf` and `epub`
5. Rename 🍪 for web (e.g. replace ` ` with `_`)
6. Extract replicated `.zip` format to `.html`
7. Rename extracted HTML file for self-hosting
8. Realize 🐭's HTML is invalid
9. Fix 🐭's broke-ass (missing `lang` attribute and `title` element)
10. Upload 🍪 to your website (you're on your own for this part)
11. Finally Finished!
12. Find mistakes 😭
13. Bake a new 🍪
14. GOTO 1

This gem solves the classic 🐭-🍪 problem by automating steps 3-8.
Will save at least 15 minutes each loop.

TODO:
Configuration supports step 9, but it hasn't been implemented yet.

Note that it doesn't have to be a resume.
There are likely other use cases that apply.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add undrive_google

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install undrive_google

## Usage

Revisiting the original story...

1. Give 🐭 your 🍪 for "safe-keeping"
2. Recognizing this SPoF, you ask 🐭 to give back a 🍪 copy
3. Run:
   ```shell
   undrive_google
   ```
4. Upload 🍪 to your website (you're on your own for this part)
5. Finally Finished!
6. Find mistakes 😭
7. Bake a new 🍪
8. GOTO 1

In order for the fantasy above to be realized,
you must to a bit of initial configuration, but you already knew that.

## Configuration

You'll probably want to follow [these (outdated) steps](https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md#on-behalf-of-no-existing-users-service-account)
to create a service account.

At the end of the process a `[siteid]-[first-12-chars-of-key].json` file will be
downloaded to your computer. **DO NOT EXPOSE THE KEY**, i.e. do not push it
to any public source repository.

When you run the `undrive_google` command this JSON key file should be in the
current directory.

Additionally, an optional `undrive_google.yml` file in the
current directory can give you control over the behavior.

What goes in the `undrive_google.yml` file?

### Default: Liberate All Formats

All non-commented values shown are default.
```yaml
# [PATH] Path to the JSON file with Google Service Account Key
key_file: 'service_account_private_key.json'

# ID of file to liberate, as key or title
file_id: '<actual-key-or-title>'
file_by: 'key' # or 'title'

# [String, Array<String>] Which extensions to download?
extensions: 'all'

# [Boolean] The HTML format download comes as a .zip archive.
# Want the .zip unzipped? (only relevant if extensions is `all`, or includes `zip`)
unzip: true
# [Boolean] Keep the .zip after extracting the `.html`?
keep_zip: true

# Rename downloaded files?
# rename_<type>, where type is:
#   1. a downloadable format name, like `odt`, `docx`, `pdf`, etc
#   2. html (which isn't downloadable, has to be unzipped from .zip)
# e.g.
# rename_html: 'resume.html'

# Rename downloaded files following a pattern?
# Only applies to files not explicitly specified with rename-<type>
# Value will be splatted to gsub
rename_pattern:
  - "_"
  - " "

# [PATH]
dir: '' # defaults to current working directory

verbose: true # or false

#
# TODO: implementation for title and lang
#
# [String] HTML title element inner text.
title: '' # When empty, defaults to the title of the file.

# [String] If unzipping `.zip`, adds lang attribute to html tag,
#            value is like `fr`, `es`, etc.
lang: 'en'
```

### Example: Liberate Specific Formats (keeping other defaults)

In this example we choose to download only the `odt`, `txt`, and `epub` extensions,
and leave the remaining settings as default, except for `title`.

```yaml
# [String, Array<String>] Which extensions to download?
extensions:
   - 'odt'
   - 'txt'
   - 'epub'

title: 'My Cool HTML'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports are welcome on Source Hut at [https://todo.sr.ht/~galtzo/undrive_google](https://todo.sr.ht/~galtzo/undrive_google).
Patches are welcome on Source Hut at [https://lists.sr.ht/~galtzo/undrive_google-devel](https://lists.sr.ht/~galtzo/undrive_google-devel)
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [code of conduct](https://git.sr.ht/~galtzo/undrive_google/tree/main/item/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UndriveGoogle project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://git.sr.ht/~galtzo/undrive_google/tree/main/item/CODE_OF_CONDUCT.md).
