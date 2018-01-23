class User < ActiveRecord::Base
  has_many :spreadsheets
  has_many :entries
  has_many :categories
  has_many :skills
  has_many :descriptions

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, confirmation: true, allow_nil: true
end
