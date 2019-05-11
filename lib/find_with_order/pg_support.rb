module FindWithOrder::PGSupport
  class << self
    def find_with_order(relation, ids)
      # return relation.where(id: ids).order("array_position(ARRAY[#{ids.join(',')}], #{relation.table_name}.id)").to_a #array_position is only support in PG >= 9.5
      return relation.where(id: ids)
                     .joins("JOIN (SELECT id.val, row_number() over() FROM (VALUES(#{to_sql_values(ids)})) AS id(val)) AS id ON (#{relation.table_name}.id = id.val)")
                     .order('row_number')
    end

    def where_with_order(relation, column, ids)
      with_order(relation.where(column => ids), column, ids)
    end

    def with_order(relation, column, ids, null_first: false)
      if column.is_a?(Symbol) and relation.column_names.include?(column.to_s)
        column = "#{relation.connection.quote_table_name(relation.table_name)}.#{relation.connection.quote_column_name(column)}"
      else
        column = column.to_s
      end
      ids = ids.reverse if null_first
      return relation.joins("LEFT JOIN (SELECT id.val, row_number() over() FROM (VALUES(#{to_sql_values(ids)})) AS id(val)) AS id ON (#{column} = id.val)")
                     .order(null_first ? 'row_number DESC' : 'row_number')
    end

    private

    def to_sql_values(ids)
      case ids.first
      when Numeric
        return ids.join('),(')
        # return relation.order("array_position(ARRAY[#{ids.join(',')}], #{column})") #array_position is only support in PG >= 9.5
      when String
        ids.map!{|s| ActiveRecord::Base.connection.quote_string(s) }
        return "'#{ids.join("'),('")}'"
        # return relation.order("array_position(ARRAY['#{ids.join("','")}']::varchar[], #{column})") #array_position is only support in PG >= 9.5
      else
        raise "not support type: #{ids.first.class}"
      end
    end
  end
end
