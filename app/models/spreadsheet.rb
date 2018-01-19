class Spreadsheet < ActiveRecord::Base
  belongs_to :user
  has_many :rows

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
