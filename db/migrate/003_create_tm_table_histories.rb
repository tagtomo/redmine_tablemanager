class CreateTmTableHistories < ActiveRecord::Migration
  def change
    create_table :tm_table_histories do |t|
      t.string :project_name
      t.string :table_name
      t.string :table_name_jp
      t.string :revision_number
      t.text :note
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
