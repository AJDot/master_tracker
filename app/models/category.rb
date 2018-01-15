class Category < ActiveRecord::Base
  has_many :entries

  belongs_to :user

  validates :name, uniqueness: { scope: :user_id, case_sensitive: false}
end
