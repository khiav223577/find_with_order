ActiveRecord::Base.establish_connection(
  "adapter"  => "postgresql",
  "database" => "travis_ci_test",
)

ActiveRecord::Schema.define do
  enable_extension 'uuid-ossp'
  enable_extension 'pgcrypto'

  create_table :uuid_users, force: true, id: :uuid  do |t|
    t.string :account
  end
end
