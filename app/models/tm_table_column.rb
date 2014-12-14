class TmTableColumn < ActiveRecord::Base
  unloadable
  attr_accessible :id, :column_number, :column_name, :column_name_jp, :column_type, :column_size, :column_null, :column_default, :column_p_key, :column_f_key, :note, :tm_table_id,:_destroy
  belongs_to :tm_table
end
