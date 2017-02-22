ActiveRecord::Schema.define do
  self.verbose = false
  create_table :users, :force => true do |t|
    t.string :name
    t.string :email
  end
end
class User < ActiveRecord::Base

end
users = User.create([
  {:name => 'John', :email => 'john@example.com'},
  {:name => 'Pearl', :email => 'pearl@example.com'},
  {:name => 'Kathenrie', :email => 'kathenrie@example.com'},
])
