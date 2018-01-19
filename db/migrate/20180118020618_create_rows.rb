class CreateRows < ActiveRecord::Migration[5.1]
  def change
    create_table :rows do |t|
      t.integer :category_id, :skill_id, :description_id, :spreadsheet_id
      t.timestamps
    end
  end
end
