class Row < ActiveRecord::Base
  belongs_to :spreadsheet
  belongs_to :category
  belongs_to :skill
  belongs_to :description

  validates_presence_of :spreadsheet, :category, :skill, :description
end
