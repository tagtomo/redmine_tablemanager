class CreateTmTableColumnHistories < ActiveRecord::Migration
  def change
    create_table :tm_table_column_histories do |t|
      t.integer :tm_table_history_id
      t.integer :column_number
      t.string :column_name
      t.string :column_name_jp
      t.string :column_type
      t.string :column_size
      t.boolean :column_null
      t.string :column_default
      t.boolean :column_p_key
      t.boolean :column_f_key
      t.text :note
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
