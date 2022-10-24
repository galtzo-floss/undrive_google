## Contributing

Bug reports are welcome on GitLab at [https://todo.sr.ht/~galtzo/undrive_google][bug-reports].
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct][conduct].

When you submit a patch, please include updated tests.
Send the patch to the [mailing list][⛳mail-list].
For help sending patches to this list, please consult [git-send-email.io][git-send-email].
Please review our mailing list [etiquette guide][mail-list-etiquette-guide]
and ensure your email client is
correctly configured before posting. Thanks!

No one has posted to this list yet.


## Release

To release a new version:

1. update the version number in `version.rb`
2. run `bundle exec rake build:checksum`
3. move the built gem to project root
4. run `bin/checksum` to create the missing SHA256 checksum
5. move the built gem back to `pkg/`
6. run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org][rubygems].

NOTE: You will need to have a public key in `certs/`, and list your cert in the
`gemspec`, in order to sign the new release.
See: [RubyGems Security Guide][rubygems-security-guide]

## Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

[comment]: <> (Following links are used by README, CONTRIBUTING, Homepage)

[conduct]: https://git.sr.ht/~galtzo/undrive_google/tree/main/item/CODE_OF_CONDUCT.md
[bug-reports]: https://todo.sr.ht/~galtzo/undrive_google
[git-send-email]: https://git-send-email.io/
[⛳mail-list]: https://lists.sr.ht/~galtzo/undrive_google-devel
[mail-list-etiquette-guide]: https://man.sr.ht/lists.sr.ht/etiquette.md
[rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
[rubygems]: https://rubygems.org
