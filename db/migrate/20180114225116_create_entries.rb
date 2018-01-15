class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.integer :duration
      t.datetime :date
      t.integer :user_id, :category_id, :skill_id, :description_id
      t.timestamps
    end
  end
end
