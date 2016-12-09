# Sidetiq::Timezone

This library makes Sidetiq use the application time zone instead of
the system time zone, which is typically determined by /etc/localtime
or the TZ environment variable.

You can tell it to use a specific time zone, otherwise the value of
`Time.zone` (defined by ActiveSupport/Rails) is implied.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidetiq-timezone'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidetiq-timezone

## Usage

If you want to explicitly specify a time zone for the Sidetiq
scheduler, call `Sidetiq.clock.time_zone=` as follows somewhere in
your application like `config/initializers/sidetiq.rb` if you are
using Rails.

```ruby
Sidetiq.clock.time_zone = ActiveSupport::TimeZone['Tokyo']
```

Otherwise, it is automatically set to `Time.zone` when the first class
to include `Sidetiq::Schedulable` is defined.

There is no per-worker time zone support since Sidetiq currently has
just one shared clock that rules all scheduled workers.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Version History

- 0.2.0

  Support Sidetiq 0.8 (no functional change, just dependency updates)

- 0.1.0

  Initial release

## Contributing

1. Fork it ( https://github.com/knu/sidetiq-timezone/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

Copyright (c) 2014-2016 Akinori MUSHA.

Licensed under the 2-clause BSD license.  See `LICENSE.txt` for
details.

Visit the [GitHub Repository](https://github.com/knu/sidetiq-timezone)
for the latest information.
