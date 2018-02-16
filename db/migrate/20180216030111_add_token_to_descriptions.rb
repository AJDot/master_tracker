class AddTokenToDescriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :descriptions, :token, :string
  end
end
