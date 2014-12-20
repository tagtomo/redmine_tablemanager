class TmTable < ActiveRecord::Base
  unloadable

  attr_accessible :project_name, :table_name, :table_name_jp, :revision_number, :note, :tm_table_columns_attributes
  has_many :tm_table_columns #,->{order("column_number ASC") }
  has_many :tm_table_histories, foreign_key: [:project_name, :table_name],primary_key: [:project_name, :table_name]
  accepts_nested_attributes_for :tm_table_columns , allow_destroy: true

  scope :project_by,  lambda { |project_name| where("project_name = ?", "#{project_name}") }
  scope :table_name_by,  lambda { |table_name| where("table_name = ?", "#{table_name}") }
  scope :order_rev_asc, lambda { order("revision_number ASC")}
  scope :order_rev_desc, lambda { order("revision_number DESC")}

  before_save :rev_set #更新時（create,update時に規定値をセットする）

  #コミット処理
  def commit

    if self.tm_table_histories.exists?
      self.revision_number = (tm_table_histories.maximum(:revision_number).to_i + 1).to_s
    else
      self.revision_number = "1"
    end

    data_attributes = self.attributes
    #自動更新項目を除外
    data_attributes.except! "id","created_at","updated_at"
    #履歴番号を設定
    #data_attributes.merge!(history_no)
    new_history = self.tm_table_histories.new(data_attributes)
    new_history.save
    self.update_column( :revision_number ,self.revision_number )
  end

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
    yml = "# " + self[:table_name] + ".ja.yml\n"
    yml << "ja:\n"
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

  private

  #編集時にはrevision_numberを固定で"no commit"を設定
  def rev_set
    self.revision_number = "no commit"
  end

end
