ActiveRecord::Base.establish_connection(
  "adapter"  => "postgresql",
  "database" => "travis_ci_test",
)
require 'seeds'
