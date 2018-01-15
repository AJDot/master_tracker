class CreateCategorySkills < ActiveRecord::Migration[5.1]
  def change
    create_table :category_skills do |t|
      t.integer :category_id, :skill_id
      t.timestamps
    end
  end
end
