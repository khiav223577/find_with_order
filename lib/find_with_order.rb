require "find_with_order/version"
require 'active_record'

class << ActiveRecord::Base
  def find_with_order(ids)
    return none if ids.blank?
    ids = ids.uniq
    return where(id: ids).order("field(id, #{ids.join(',')})").to_a
  end
  def where_with_order(column, ids)
    return none if ids.blank?
    ids = ids.uniq
    return where(column => ids).order("field(#{column}, #{ids.map(&:inspect).join(',')})")
  end
end
unless ActiveRecord::Base.respond_to?(:none) # extend only if not implement yet
  class ActiveRecord::Base
    def self.none #For Rails 3
      where('1=0')
    end
  end
end
