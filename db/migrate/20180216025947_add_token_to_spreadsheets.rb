class AddTokenToSpreadsheets < ActiveRecord::Migration[5.1]
  def change
    add_column :spreadsheets, :token, :string
  end
end
