require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true
    column_data = []

    sql = "PRAGMA table_info('#{table_name}')"
    DB[:conn].execute(sql).each {|o| column_data << o["name"]}

    column_data.compact
  end

  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end

  def initialize(options = {})
    options.each {|key, value| self.send("#{key}=", value)}
  end
end
