# CheckFiles

[![Travis-CI](https://travis-ci.org/fnando/check_files.svg)](https://travis-ci.org/fnando/check_files)
[![Code Climate](https://codeclimate.com/github/fnando/check_files/badges/gpa.svg)](https://codeclimate.com/github/fnando/check_files)
[![Test Coverage](https://codeclimate.com/github/fnando/check_files/badges/coverage.svg)](https://codeclimate.com/github/fnando/check_files/coverage)
[![Gem](https://img.shields.io/gem/v/check_files.svg)](https://rubygems.org/gems/check_files)
[![Gem](https://img.shields.io/gem/dt/check_files.svg)](https://rubygems.org/gems/check_files)

Ever forgot to restart the development web server when you change things like `Gemfile` or `config/environments/development.rb`? You're not alone. There are a lot of cases to keep in mind:

- You upgrade and/or remove/add gems to `Gemfile`.
- You change environment values (e.g. `config/environments/development.rb`).
- You change initializer values.
- You add/remove directories to/from `app`.
- You add/remove files to/from `config/locales`.
- You change configuration files living at `config/*.yml` .

With this gem you don't have to think about it. Every time you change files that require a restart, an exception will be raised and you'll know what you have to do.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "check_files", group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install check_files

## Usage

You don't have to configure anything but there are some configurable values if you want. The following values are the defaults:

```ruby
# The list of files/directories that must be checked.
# Patterns ended with /* will just check the entries list (not the content).
config.check_files.paths = [
  "Gemfile.lock",
  "config/initializers/**/*.rb",
  "config/{application,boot,config,environment}.rb",
  "config/*.yml",
  "config/environments/**/*.rb",
  "app/*",
  "config/locales/**/*"
]

# The notifier that will be used. By default it raises an exception on Rails < 5 or restarts the web server (Rails 5+).
# You can use CheckFiles::Notifiers::Exception, CheckFiles::Notifiers::Logging or CheckFiles::Notifiers::Restart (Rails 5+).
config.check_files.notifier = CheckFiles::Notifiers::Exception
```

To overwrite any of these values, just create the initializer `config/initializers/check_files.rb` like the following:

```ruby
Rails.configuration.check_files.notifier = CheckFiles::Notifiers::Logging
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fnando/check_files. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
