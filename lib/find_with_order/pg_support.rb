module FindWithOrder
  module PGSupport
    def self.find_with_order(relation, ids)
      ids = ids.uniq
      return relation.where(id: ids).order("array_position(ARRAY[#{ids.join(',')}], #{relation.table_name}.id)").to_a
    end
    def self.where_with_order(relation, column, ids)
      ids = ids.uniq
      relation = relation.where(column => ids)
      case ids.first
      when Numeric ; return relation.order("array_position(ARRAY[#{ids.join(',')}], #{column})")
      when String  ; return relation.order("array_position(ARRAY['#{ids.map{|s| s.gsub("'", "''") }.join('\',\'')}']::varchar[], #{column})")
      else
        raise 'not support type: #{ids.first.class}'
      end
    end
  end
end
