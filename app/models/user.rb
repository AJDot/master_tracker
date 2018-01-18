class User < ActiveRecord::Base
  has_many :spreadsheets
  has_many :entries
  has_many :categories
  has_many :skills
  has_many :descriptions

  validates :username, presence: true, uniqueness: true
end
