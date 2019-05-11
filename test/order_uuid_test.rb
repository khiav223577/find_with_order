require 'test_helper'

class OrderUuidTest < Minitest::Test
  def setup
    @user1 = UuidUser.find_by(account: 'jimmy')
    @user2 = UuidUser.find_by(account: 'john')
    @user3 = UuidUser.find_by(account: 'peter')
  end

  def test_find_id_with_order
    test_order = proc{|order|
      expected = UuidUser.where(:id => order).to_a.sort_by{|user| order.index(user.id) }
      assert_equal expected, UuidUser.find_with_order(order)
    }
    test_order.call [@user1.id, @user2.id, @user3.id]
    test_order.call [@user1.id, @user3.id, @user2.id]
    test_order.call [@user2.id, @user1.id, @user3.id]
    test_order.call [@user2.id, @user3.id, @user1.id]
    test_order.call [@user3.id, @user1.id, @user2.id]
    test_order.call [@user3.id, @user2.id, @user1.id]
  end
end
