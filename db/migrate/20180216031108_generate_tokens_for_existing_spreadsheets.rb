class GenerateTokensForExistingSpreadsheets < ActiveRecord::Migration[5.1]
  def change
    Spreadsheet.all.each do |spreadsheet|
      spreadsheet.token = SecureRandom.urlsafe_base64
      spreadsheet.save
    end
  end
end
