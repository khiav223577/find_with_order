require "find_with_order/version"
require 'active_record'

class << ActiveRecord::Base
  def find_with_order(ids)
    ids = ids.uniq
    return none if ids.empty?
    where(id: ids).order("field(id, #{ids.join(',')})")
  end
end
unless ActiveRecord::Base.respond_to?(:none) # extend only if not implement yet
  class ActiveRecord::Base
    def self.none #For Rails 3
      where('1=0')
    end
  end
end
