require 'test_helper'

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

  def test_find_empty
    expected = []
    assert_equal expected, User.find_with_order([])
  end
end
