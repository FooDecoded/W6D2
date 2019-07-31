require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return self.columns if self.columns
    cols = DBConnection.execute2("SELECT * FROM #{table_name}").first.map { |column_name| column_name.to_sym   }
    @columns = cols
  end

  def self.finalize!
    # Do we have to use columns or slef.columsn
    attr_accessor(*self.columns)
    self.attributes
  end

  def self.table_name=(table_name)
    # ...
  end

  def self.table_name
    ## how to get the class name
    @table_name ||= self.name.underscore.pluralize
  end

  def self.all
    # ...
    res = DBConnection.execute2("SELECT #{table_name}.* FROM #{table_name}")[1..-1]
    parse_all(res)
  end

  def self.parse_all(results)
    # ...
    results.map do |obj|
      self.new(obj)
    end
  end

  def self.find(id)
    # ...
    self.all.find { |obj| obj.id = id }
  end

  def initialize(params = {})
    # ...
    attr_hash = SQLObject.attributes
    params.each do |key, value|
      raise "unknown attribute '#{key}'" unless attr_hash[key]
    end
  end

  def attributes
    # ...
    hash = {}
    self.columns.each do |key, value|
      hash[key] = value if value
    end
    hash
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
    col_names_str = ""
    values_arr = ""
    cols_arr = self.columns
    cols_num = cols_arr.length
    cols_arr.each_with_index do |col, idx|
      if idx == 0
        col_names_str += "( #{col.to_s} "
      elsif idx == length - 1
        col_names_str += "#{col.to_s} )" 
      else
        col_names_str += "#{col.to_s} , "
      end
       

      
    end

    

  end

  def update
    # ...
  end

  def save
    # ...
  end
end
