ActiveRecord::Base.establish_connection(
  "adapter"  => "postgresql",
  "database" => "travis_ci_test",
)

class ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
  if not method_defined?(:enable_extension)
    def enable_extension(name)
      exec_query("CREATE EXTENSION IF NOT EXISTS \"#{name}\"")
    end
  end
end

ActiveRecord::Schema.define do
  enable_extension 'uuid-ossp'
  enable_extension 'pgcrypto'

  create_table :uuid_users, force: true, id: :uuid  do |t|
    t.string :account
  end
end
