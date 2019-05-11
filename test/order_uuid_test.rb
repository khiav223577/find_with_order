require 'test_helper'

class OrderUuidTest < Minitest::Test
  def setup
    skip if ENV['DB'] != 'pg'
    @user1 = UuidUser.find_by(account: 'jimmy')
    @user2 = UuidUser.find_by(account: 'john')
    @user3 = UuidUser.find_by(account: 'peter')
  end

  def test_find_id_with_order
    test_order = proc{|order|
      expected = UuidUser.where(id: order).to_a.sort_by{|user| order.index(user.id) }
      assert_equal expected, UuidUser.find_with_order(order)
    }
    test_order.call [@user1.id, @user2.id, @user3.id]
    test_order.call [@user1.id, @user3.id, @user2.id]
    test_order.call [@user2.id, @user1.id, @user3.id]
    test_order.call [@user2.id, @user3.id, @user1.id]
    test_order.call [@user3.id, @user1.id, @user2.id]
    test_order.call [@user3.id, @user2.id, @user1.id]
  end

  def test_find_account_with_order
    test_order = proc{|order|
      expected = UuidUser.where(account: order).to_a.sort_by{|user| order.index(user.account) }
      assert_equal expected, UuidUser.where_with_order(:account, order)
    }
    test_order.call %w(john jimmy peter)
    test_order.call %w(john peter jimmy)
    test_order.call %w(jimmy john peter)
    test_order.call %w(jimmy peter john)
    test_order.call %w(peter john jimmy)
    test_order.call %w(peter jimmy john)
  end

  def test_none
    assert_equal [], UuidUser.none.find_with_order([@user1.id, @user2.id, @user3.id])
  end

  def test_find_empty
    assert_equal [], UuidUser.find_with_order([])
    assert_equal [], UuidUser.find_with_order(nil)
  end

  def test_where_empty
    assert_equal [], UuidUser.where_with_order(:account, []).to_a
    assert_equal [], UuidUser.where_with_order(:account, nil).to_a
  end

  def test_with_order
    id_order = [@user3.id, @user1.id]
    assert_equal [@user3.id, @user1.id, @user2.id], UuidUser.with_order(:id, id_order).pluck(:id)
    assert_equal [@user2.id, @user3.id, @user1.id], UuidUser.with_order(:id, id_order, null_first: true).pluck(:id)
  end
end
