class CreateDescriptionSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :description_skills do |t|
      t.integer :description_id, :skill_id
      t.timestamps
    end
  end
end
