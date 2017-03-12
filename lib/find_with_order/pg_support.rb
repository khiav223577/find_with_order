module FindWithOrder
  module PGSupport
    def self.find_with_order(relation, ids)
      # return relation.where(id: ids).order("array_position(ARRAY[#{ids.join(',')}], #{relation.table_name}.id)").to_a #array_position is only support in PG >= 9.5
      return relation.where(id: ids)
                     .joins("JOIN (SELECT id.val, row_number() over() FROM (VALUES(#{ids.join('),(')})) AS id(val)) AS id ON (#{relation.table_name}.id = id.val)")
                     .order('row_number')
    end
    def self.where_with_order(relation, column, ids)
      relation = relation.where(column => ids)
      case ids.first
      when Numeric
        # return relation.order("array_position(ARRAY[#{ids.join(',')}], #{column})") #array_position is only support in PG >= 9.5
        return relation.joins("JOIN (SELECT id.val, row_number() over() FROM (VALUES(#{ids.join('),(')})) AS id(val)) AS id ON (#{column} = id.val)")
                       .order('row_number')
      when String
        ids.map!{|s| ActiveRecord::Base.connection.quote_string(s) }
        # return relation.order("array_position(ARRAY['#{ids.join("','")}']::varchar[], #{column})") #array_position is only support in PG >= 9.5
        return relation.joins("JOIN (SELECT id.val, row_number() over() FROM (VALUES('#{ids.join("'),('")}')) AS id(val)) AS id ON (#{column} = id.val)")
                       .order('row_number')
      else
        raise "not support type: #{ids.first.class}"
      end
    end
  end
end
