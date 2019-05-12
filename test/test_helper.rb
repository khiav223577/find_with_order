require "simplecov"
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'find_with_order'

require 'minitest/autorun'

case ENV['DB']
when 'mysql' ; require 'lib/mysql2_connection'
when 'pg'    ; require 'lib/postgresql_connection'
else         ; raise "no database"
end

require 'lib/patches'
require 'lib/seeds'
