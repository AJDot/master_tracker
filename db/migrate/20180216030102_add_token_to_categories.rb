class AddTokenToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :token, :string
  end
end
