Salesforce originally used case-sensitive 15-character alphanumeric IDs.
Later on, added three error-correcting characters to make their 18-character ID.

## Usage

#### `SalesforceIdFormatter.to_18`

- Converts a 15-char String to its equivalent 18-char ID as a String:
  `SalesforceIdFormatter.to_18('70130000001tcyI')  # =>  '70130000001tcyIAAQ'``
- Leaves a 18-char String unaltered:
  `SalesforceIdFormatter.to_18('70130000001tcyIAAQ') # =>  '70130000001tcyIAAQ'`
- Raises `SalesforceIdFormatter::InvalidId` if the given ID doesn't follow
  Salesforce's conventions
http://www.salesforce.com/us/developer/docs/api/Content/field_types.htm#i1435616
TL;DR: 15 or 18 alphanumeric, case-sensitive chars

#### `SalesforceIdFormatter.to_15`

- Applies the same rules as `to_18`, returning 15-char IDs instead.

#### `SalesforceIdFormatter.valid_id?`

- Returns false if passed string is either not 15/18 characters or is not
  alphanumeric.

## Attribution
Code is a modified version of https://gist.github.com/jbaylor-rpx/2691624
(original doesn't seem to calculate control digits correctly)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'salesforce_id_formatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install salesforce_id_formatter

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/salesforce_id_formatter/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
