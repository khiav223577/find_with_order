require "find_with_order/version"
require 'active_record'

class << ActiveRecord::Base
  def find_with_order(ids)
    ids = ids.uniq
    return none if ids.empty?
    where(id: ids).order("field(id, #{ids.join(',')})")
  end
end
