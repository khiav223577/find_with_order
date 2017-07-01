require "find_with_order/version"
require "find_with_order/mysql_support"
require "find_with_order/pg_support"
require 'active_record'

module FindWithOrder
  class << self
    def supporter
      return FindWithOrder::PGSupport if defined?(PG)
      return FindWithOrder::MysqlSupport
    end
  end
end

class << ActiveRecord::Base
  def find_with_order(ids)
    return none if ids.blank?
    return FindWithOrder.supporter.find_with_order(self, ids.uniq)
  end

  def where_with_order(column, ids)
    return none if ids.blank?
    return FindWithOrder.supporter.where_with_order(self, column, ids.uniq)
  end

  def with_order(column, ids, null_first: false)
    FindWithOrder.supporter.with_order(self, column, ids, null_first: null_first)
  end
end

unless ActiveRecord::Base.respond_to?(:none) # extend only if not implement yet
  class ActiveRecord::Base
    def self.none #For Rails 3
      where('1=0')
    end
  end
end
