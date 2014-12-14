class TmTable < ActiveRecord::Base
  unloadable

  attr_accessible :project_name, :table_name, :table_name_jp, :revision_number, :note, :tm_table_columns_attributes
  has_many :tm_table_columns #,->{order("column_number ASC") }
  accepts_nested_attributes_for :tm_table_columns , allow_destroy: true

  def to_gentext
  	sfdata = "rails generate scaffold " + self[:table_name]
  	self.tm_table_columns.each do |tm_table_column|
      case tm_table_column[:column_type]
  	  when "character"
  		column_type = "string"
  	  when "numeric"
  		column_type = "integer"
  	  else
  	  	column_type = tm_table_column[:column_type]
  	  end
  	  sfdata << " " + tm_table_column[:column_name] + ":" + column_type
  	end
  	return sfdata
  end

  def to_localeyml
    yml = "ja:\n"
    yml << "  activerecord:\n"
    yml << "    models:\n"
    yml << "      " + self[:table_name] + ": " + self[:table_name_jp] +"\n"
    yml << "    attributes:\n"
    yml << "      " + self[:table_name] + ":\n"
    self.tm_table_columns.each do |tm_table_column|
      yml << "        " + tm_table_column[:column_name] + ": " + tm_table_column[:column_name_jp] + "\n"
    end
    return yml
  end
end
