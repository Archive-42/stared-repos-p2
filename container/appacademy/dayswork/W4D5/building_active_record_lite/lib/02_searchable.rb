require_relative "db_connection"
require_relative "01_sql_object"

module Searchable
  def where(params)
    where_line = params.keys.map { |key| "#{key} = ?" }.join(" AND ") #produces a string for query

    results = DBConnection.execute(<<-SQL, *params.values)
    SELECT * 
    FROM #{self.table_name} 
    WHERE #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
