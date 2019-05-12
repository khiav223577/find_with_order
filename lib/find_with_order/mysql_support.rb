# frozen_string_literal: true

module FindWithOrder::MysqlSupport
  class << self
    def find_with_order(relation, ids)
      relation.where(id: ids)
              .order("field(#{relation.table_name}.id, #{ids.join(',')})")
              .to_a
    end

    def where_with_order(relation, column, ids)
      with_order(relation.where(column => ids), column, ids, null_first: true)
    end

    def with_order(relation, column, ids, null_first: false)
      if column.is_a?(Symbol) and relation.column_names.include?(column.to_s)
        column = "#{relation.connection.quote_table_name(relation.table_name)}.#{relation.connection.quote_column_name(column)}"
      else
        column = column.to_s
      end
      return relation.order("field(#{column}, #{ids.map(&:inspect).join(',')})") if null_first 
      return relation.order("field(#{column}, #{ids.reverse.map(&:inspect).join(',')}) DESC")
    end
  end
end
