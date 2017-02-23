[![Gem Version](https://img.shields.io/gem/v/find_with_order.svg?style=flat)](https://rubygems.org/gems/find_with_order)
[![Build Status](https://travis-ci.org/khiav223577/find_with_order.svg?branch=master)](https://travis-ci.org/khiav223577/find_with_order)
[![RubyGems](http://img.shields.io/gem/dt/find_with_order.svg?style=flat)](https://rubygems.org/gems/find_with_order)
[![Code Climate](https://codeclimate.com/github/khiav223577/find_with_order/badges/gpa.svg)](https://codeclimate.com/github/khiav223577/find_with_order)
[![Test Coverage](https://codeclimate.com/github/khiav223577/find_with_order/badges/coverage.svg)](https://codeclimate.com/github/khiav223577/find_with_order/coverage)

# FindWithOrder

Find records in the same order of input array.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'find_with_order'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install find_with_order

## Usage

### Find records in the same order of input IDs
```rb
User.find([3, 1, 5]).map(&:id)
# => [1, 3, 5] 

User.find_with_order([3, 1, 5]).map(&:id)
# => [3, 1, 5] 
```
### Support order other columns
```rb
User.where(name: %w(Pearl John Kathenrie)).pluck(:name)
# => ['John', 'Pearl', 'Kathenrie']

User.where_with_order(:name, %w(Pearl John Kathenrie)).pluck(:name)
# => ['Pearl', 'John', 'Kathenrie']
```

## Benchmark

```
                                       user     system      total        real
Find with order                    0.030000   0.000000   0.030000 (  0.033517)
Find then sort by index            1.510000   0.030000   1.540000 (  1.706246)
Find then sort by hash mapping     1.120000   0.010000   1.130000 (  1.192891)
```
[test script](https://github.com/khiav223577/find_with_order/issues/4)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khiav223577/find_with_order. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

