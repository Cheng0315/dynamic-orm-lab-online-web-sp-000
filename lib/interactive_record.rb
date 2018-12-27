require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def table_name
    self.to_s.downcase.plurals
  end

  def column_name
    DB[:conn].results_as_hash = true
    column_data = []

    sql = "PRAGMA table_info('#{table_name}')"
    DB[:conn].execute(sql).each {|o| column_data << o[:name]}

    column_data.compact
  end
end
