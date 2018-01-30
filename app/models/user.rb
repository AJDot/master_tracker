class User < ActiveRecord::Base
  has_many :spreadsheets
  has_many :entries, ->{ order("created_at DESC") }
  has_many :categories
  has_many :skills
  has_many :descriptions

  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 5 }, confirmation: true, allow_nil: true

  def recent_entries(n = 5)
    entries.limit(n)
  end
end
