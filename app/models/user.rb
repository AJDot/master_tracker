class User < ActiveRecord::Base
  has_many :spreadsheets
  has_many :entries
  has_many :categories
  has_many :skills
  has_many :descriptions

  has_secure_password # validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, confirmation: true
  validates :password_confirmation, presence: true
end
