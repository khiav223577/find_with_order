module FindWithOrder
  module MysqlSupport
    class << self
      def find_with_order(relation, ids)
        return relation.where(id: ids).order("field(#{relation.table_name}.id, #{ids.join(',')})").to_a
      end

      def where_with_order(relation, column, ids)
        return relation.where(column => ids).order("field(#{column}, #{ids.map(&:inspect).join(',')})")
      end

      def with_order(relation, column, ids)
        relation.order("field(#{column}, #{ids.map(&:inspect).join(',')})")
      end
    end
  end
end
