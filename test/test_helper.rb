require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'find_with_order'

require 'minitest/autorun'

ActiveRecord::Base.establish_connection(
  "adapter"  => "mysql2",
  "database" => "travis_ci_test",
)
require 'seeds'
