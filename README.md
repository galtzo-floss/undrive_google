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

OTOH, if you want to "own", host, track, etc your resume files, DO use this gem.

## Story Time

Imagine Google Drive is a 🐭
Imagine your resume (or any file, really) is a 🍪
Mouse has a cookie 🖨

Tell me if you've heard this one already.

1. Give 🐭 your 🍪 for hosting
2. But you want to host the 🍪 too - ask 🐭 to give it back
3. "I'll run it through my 🍪 🖨 instead" - Mouse
4. 🖨 spits out various 🍪 formats: `pdf`, `odt`, `docx`, `txt`, `rtf` and `epub`
5. Rename replicated 🍪 (e.g. replace ` ` with `_`)
6. Extract the replicated `.zip` format to `.html`
7. Rename extracted HTML file for self-hosting
8. Realize 🐭's HTML is invalid
9. Fix 🐭's broke-ass (missing `lang` attribute and `title` element)
10. Upload 🍪 to your website (you're on your own for this part)
11. Finally Finished!
12. Find mistakes 😭
13. Bake a new 🍪
14. GOTO 1

This gem solves the classic mouse-cookie problem by automating steps 3-9.
Will save at least 15 minutes each loop.

Note that it doesn't have to be a resume.
There are likely other use cases that apply.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add undrive_google

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install undrive_google

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pboling/undrive_google. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/pboling/undrive_google/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UndriveGoogle project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pboling/undrive_google/blob/main/CODE_OF_CONDUCT.md).
