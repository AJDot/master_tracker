class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :skill
  belongs_to :description

  validates_presence_of :user, :category, :skill, :description, :date, :duration
  validates :duration, numericality: { greater_than: 0, only_integer: true}
end
