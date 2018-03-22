# MRZ

[![Build Status](https://travis-ci.org/streetspotr/mrz.svg?branch=master)](https://travis-ci.org/streetspotr/mrz)

MRZ is a small library which can parse MRZ codes on ID cards and passports. It was inspired by https://github.com/cheminfo-js/mrz.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mrz'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mrz

## Usage

```
id_card = [
    "IDD<<T220001293<<<<<<<<<<<<<<<",
    "6408125<2010315D<<<<<<<<<<<<<4",
    "MUSTERMANN<<ERIKA<PAULA<ANNA<<"
]

result = MRZ.parse(id_card)

result.valid?                      # => true
result.birth_date                  # => Date.new(1964, 8, 12)
result.birth_date_check_digit      # => "5"
result.composite_check_digit       # => "4"
result.document_code               # => "ID"
result.document_number             # => "T22000129"
result.document_check_digit        # => "3"
result.expiration_date             # => Date.new(2020, 10, 15)
result.expiration_date_check_digit # => "5"
result.first_name                  # => "ERIKA PAULA ANNA"
result.issuing_state               # => "D"
result.last_name                   # => "MUSTERMANN"
result.nationality                 # => "D"
result.optional1                   # => ""
result.optional2                   # => ""
result.sex                         # => "nonspecified" (otherwise "M" or "F")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/streetspotr/mrz.
