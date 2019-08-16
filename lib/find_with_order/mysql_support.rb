# frozen_string_literal: true
require "active_record"

module FindWithOrder::MysqlSupport
  class << self
    def find_with_order(relation, ids)
      relation.where(id: ids)
              .order(sanitize_sql_for_order(["field(?, ?)", relation.table_name, ids]))
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
      return relation.order(sanitize_sql_for_order(["field(?, ?)", column, ids.map(&:inspect)])) if null_first
      return relation.order(sanitize_sql_for_order(["field(?, ?)", column, ids.reverse.map(&:inspect)]))
    end

    delegate :sanitize_sql_for_order, to: :"ActiveRecord::Sanitization"
  end
end
