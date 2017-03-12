require "find_with_order/version"
require "find_with_order/mysql_support"
require "find_with_order/pg_support"
require 'active_record'

class << ActiveRecord::Base
  def find_with_order(ids)
    return none if ids.blank?
    ids = ids.uniq
    return FindWithOrder::PGSupport.find_with_order(self, ids) if defined?(PG)
    return FindWithOrder::MysqlSupport.find_with_order(self, ids)
  end
  def where_with_order(column, ids)
    return none if ids.blank?
    ids = ids.uniq
    return FindWithOrder::PGSupport.where_with_order(self, column, ids) if defined?(PG)
    return FindWithOrder::MysqlSupport.where_with_order(self, column, ids)
  end
end
unless ActiveRecord::Base.respond_to?(:none) # extend only if not implement yet
  class ActiveRecord::Base
    def self.none #For Rails 3
      where('1=0')
    end
  end
end
