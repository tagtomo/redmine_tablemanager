class TmTableColumn < ActiveRecord::Base
  unloadable
  attr_accessible :id, :column_number, :column_name, :column_name_jp, :column_type, :column_size, :column_null, :column_default, :column_p_key, :column_f_key, :note, :tm_table_id,:_destroy
  belongs_to :tm_table

  validates :column_name, :presence => true
  validates :column_name_jp, :presence => true
  validates :column_type, :presence => true
  validates :column_type, inclusion: { in: %w(binary boolean date datetime decimal float integer primary_key string text time timestamp),
    message: "%{value} is not a valid type" }
end
