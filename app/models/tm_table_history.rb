class TmTableHistory < ActiveRecord::Base
  unloadable
  belongs_to :tm_table, foreign_key: [:project_name, :table_name],primary_key: [:project_name, :table_name]
end
