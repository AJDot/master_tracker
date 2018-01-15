class CreateCategoryDescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :category_descriptions do |t|
      t.integer :category_id, :description_id
      t.timestamps
    end
  end
end
