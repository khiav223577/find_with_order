ActiveRecord::Schema.define do
  self.verbose = false

  create_table :users, :force => true do |t|
    t.string :name
    t.string :email
  end

  create_table :posts, :force => true do |t|
    t.integer :user_id
    t.string :title
  end
end

ActiveSupport::Dependencies.autoload_paths << File.expand_path('../models/', __FILE__)

users = User.create([
  {:name => 'John', :email => 'john@example.com'},
  {:name => 'Pearl', :email => 'pearl@example.com'},
  {:name => 'Doggy', :email => 'kathenrie@example.com'},
])

Post.create([
  {:title => "John's post1", :user_id => users[0].id},
  {:title => "John's post2", :user_id => users[0].id},
  {:title => "John's post3", :user_id => users[0].id},
  {:title => "Pearl's post1", :user_id => users[1].id},
  {:title => "Pearl's post2", :user_id => users[1].id},
  {:title => "Doggy's post1", :user_id => users[2].id},
])

if ENV['DB'] == 'pg'
  UuidUser.create([
    { account: 'jimmy' },
    { account: 'john' },
    { account: 'peter' },
  ])
end
