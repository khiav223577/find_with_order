require 'test_helper'

class FindWithOrderTest < Minitest::Test
  def setup
    
  end
  def test_that_it_has_a_version_number
    refute_nil ::FindWithOrder::VERSION
  end

  def test_basic_find_with_order
    order = [2, 1, 3]
    order_map = order.each_with_index.to_h
    expected = User.where(:id => order).to_a.sort_by{|user| order_map[user.id] }
    assert_equal expected, User.find_with_order(order)
  end
end
