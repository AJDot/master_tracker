class AddTokenToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :token, :string
  end
end
