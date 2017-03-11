module FindWithOrder
  VERSION = "1.0.1"
  module MysqlSupport
    def self.find_with_order(relation, ids)
      ids = ids.uniq
      return relation.where(id: ids).order("field(#{relation.table_name}.id, #{ids.join(',')})").to_a
    end
    def self.where_with_order(relation, column, ids)
      ids = ids.uniq
      return relation.where(column => ids).order("field(#{column}, #{ids.map(&:inspect).join(',')})")
    end
  end
end