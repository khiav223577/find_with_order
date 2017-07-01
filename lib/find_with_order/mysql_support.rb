module FindWithOrder::MysqlSupport
  class << self
    def find_with_order(relation, ids)
      relation.where(id: ids)
              .order("field(#{relation.table_name}.id, #{ids.join(',')})")
              .to_a
    end

    def where_with_order(relation, column, ids)
      with_order(relation.where(column => ids), column, ids)
    end

    def with_order(relation, column, ids)
      relation.order("field(#{column}, #{ids.map(&:inspect).join(',')})")
    end
  end
end
