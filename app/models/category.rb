class Category < ActiveRecord::Base
  has_many :entries

  belongs_to :user

  has_many :rows

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false}
end
