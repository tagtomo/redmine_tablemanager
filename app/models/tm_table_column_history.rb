class TmTableColumnHistory < ActiveRecord::Base
  unloadable
  belongs_to :tm_table_history
end
