require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name
    self.to_s.downcase.plurals
  end

  def self.column_name
    DB[:conn].results_as_hash() = true
    column_data = []
    
    sql = "PRAGMA table_info('#{table_name}')"
    DB[:conn].execute(slq).each {|o| column_data << o[:name]}
    
    column.compact
  end
end
