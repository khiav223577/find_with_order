require 'active_record/connection_adapters/mysql2_adapter'

class ActiveRecord::ConnectionAdapters::Mysql2Adapter
  NATIVE_DATABASE_TYPES[:primary_key] = "int(11) auto_increment PRIMARY KEY"
end

ActiveRecord::Base.establish_connection(
  'adapter'  => 'mysql2',
  'database' => 'github_actions_test',
  'username' => 'developer',
  'password' => 'developer_password',
  'host'     => '127.0.0.1',
  'port'     => 3306,
)
