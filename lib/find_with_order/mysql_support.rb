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
      return relation.order("field(#{column}, #{ids.map(&:inspect).join(',')})") if null_first 
      return relation.order("field(#{column}, #{ids.reverse.map(&:inspect).join(',')}) DESC")
    end
  end
end
