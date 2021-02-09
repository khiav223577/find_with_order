
# FindWithOrder

[![Gem Version](https://img.shields.io/gem/v/find_with_order.svg?style=flat)](https://rubygems.org/gems/find_with_order)
[![Build Status](https://github.com/khiav223577/find_with_order/workflows/Ruby/badge.svg)](https://github.com/khiav223577/find_with_order/actions)
[![RubyGems](http://img.shields.io/gem/dt/find_with_order.svg?style=flat)](https://rubygems.org/gems/find_with_order)
[![Code Climate](https://codeclimate.com/github/khiav223577/find_with_order/badges/gpa.svg)](https://codeclimate.com/github/khiav223577/find_with_order)
[![Test Coverage](https://codeclimate.com/github/khiav223577/find_with_order/badges/coverage.svg)](https://codeclimate.com/github/khiav223577/find_with_order/coverage)

Find records in the same order of input array.

## Supports
- Ruby 2.2 ~ 2.7
- Rails 3.2, 4.2, 5.0, 5.1, 5.2, 6.0
- MySQL, PostgreSQL

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

### Find records with the order of IDs: `find_with_order`
```rb
ids = [3, 1, 5]

User.find(ids).map(&:id)
# => [1, 3, 5]

User.find_with_order(ids).map(&:id)
# => [3, 1, 5]
```

### Support ordering by other columns: `where_with_order`
```rb
names = %w(Pearl John Doggy)

User.where(name: names).pluck(:name)
# => ['John', 'Pearl', 'Doggy']

User.where_with_order(:name, names).pluck(:name)
# => ['Pearl', 'John', 'Doggy']
```

### Support ordering only part of results: `with_order`
```rb
names = %w(Pearl John)

User.leader.with_order(:name, names).pluck(:name)
# => ['Pearl', 'John', 'Doggy']

User.leader.with_order(:name, names, null_first: true).pluck(:name)
# => ['Doggy', 'Pearl', 'John']
```


## Benchmark
### Compare with manually sorting in rails

```
                                       user     system      total        real
Find with order                    0.050000   0.010000   0.060000 (  0.074975)
Find then sort by index            2.520000   0.120000   2.640000 (  3.238615)
Find then sort by hash mapping     1.410000   0.070000   1.480000 (  1.737176)
```
[test script](https://github.com/khiav223577/find_with_order/issues/4)

### Compare with order_as_specified
```
                                       user     system      total        real
order_as_specified                 0.020000   0.000000   0.020000 (  0.703773)
where_with_order                   0.020000   0.000000   0.020000 (  0.031723)
```
[test script](https://github.com/khiav223577/find_with_order/issues/4#issuecomment-307376453)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test DB=mysql` / `rake test DB=pg` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khiav223577/find_with_order. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

