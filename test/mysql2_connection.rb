ActiveRecord::Base.establish_connection(
  "adapter"  => "mysql2",
  "database" => "travis_ci_test",
)
load 'seeds.rb'