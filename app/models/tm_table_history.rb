class TmTableHistory < ActiveRecord::Base
  unloadable
  attr_accessible :id, :project_name, :table_name, :table_name_jp, :revision_number, :note,:_destroy
  has_many :tm_table_column_histories#, allow_destroy: true
  belongs_to :tm_table, foreign_key: [:project_name, :table_name],primary_key: [:project_name, :table_name]
end
