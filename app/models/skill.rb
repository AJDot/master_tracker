class Skill < ActiveRecord::Base
  has_many :entries

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false}
end
