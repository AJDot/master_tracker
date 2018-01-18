class Spreadsheet < ActiveRecord::Base
  belongs_to :user
  has_many :rows
end
