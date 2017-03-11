require 'test_helper'
case ENV['DB']
when 'mysql'
  require 'mysql2_connection'
when 'pg'
  require 'postgresql_connection'
else
  raise "no database"
end

class FindWithOrderTest < Minitest::Test
  def setup
    
  end
  def test_that_it_has_a_version_number
    refute_nil ::FindWithOrder::VERSION
  end

  def test_find_id_with_order
    test_order = proc{|order|
      expected = User.where(:id => order).to_a.sort_by{|user| order.index(user.id) }
      assert_equal expected, User.find_with_order(order)
    }
    test_order.call [1, 2, 3]
    test_order.call [1, 3, 2]
    test_order.call [2, 1, 3]
    test_order.call [2, 3, 1]
    test_order.call [3, 1, 2]
    test_order.call [3, 2, 1]
  end

  def test_find_name_with_order
    test_order = proc{|order|
      expected = User.where(:name => order).to_a.sort_by{|user| order.index(user.name) }
      assert_equal expected, User.where_with_order(:name, order)
    }
    test_order.call %w(John Pearl Kathenrie)
    test_order.call %w(John Kathenrie Pearl)
    test_order.call %w(Pearl John Kathenrie)
    test_order.call %w(Pearl Kathenrie John)
    test_order.call %w(Kathenrie John Pearl)
    test_order.call %w(Kathenrie Pearl John)
  end

  def test_none
    assert_equal [], User.none.find_with_order([1, 2, 3])
  end

  def test_find_empty
    assert_equal [], User.find_with_order([])
    assert_equal [], User.find_with_order(nil)
  end

  def test_where_empty
    assert_equal [], User.where_with_order(:name, []).to_a
    assert_equal [], User.where_with_order(:name, nil).to_a
  end

  def test_association_find_with_order
    expected_order = ["John's post2", "John's post1", "John's post3"]
    assert_equal expected_order, Post.where_with_order(:title, expected_order).pluck(:title)
    assert_equal expected_order, User.where(:name => 'John').first.posts.where_with_order(:title, expected_order).pluck(:title)
    assert_equal [], User.where(:name => 'Pearl').first.posts.where_with_order(:title, expected_order).pluck(:title)
  end

  def test_ambiguous_id_in_join
    order = [2, 1, 3]
    assert_equal order, User.joins(:posts).uniq.find_with_order(order).map(&:id)
    assert_equal order, User.joins(:posts).uniq.where_with_order(:'users.id', order).pluck(:id)
  end
end



