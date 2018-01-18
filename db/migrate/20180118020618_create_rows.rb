class CreateRows < ActiveRecord::Migration[5.1]
  def change
    create_table :rows do |t|
      t.string :category
      t.string :skill
      t.string :description
      t.integer :spreadsheet_id
      t.timestamps
    end
  end
end
