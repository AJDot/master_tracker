class Spreadsheet < ActiveRecord::Base
  belongs_to :user
  has_many :rows

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates_presence_of :user

  def create_row
    category = user.categories.first
    skill = user.skills.first
    description = user.descriptions.first
    return false unless category && skill && description
    rows << Row.new(category: category, skill: skill, description: description)
    true
  end

  def create_date
    created_at.strftime('%b %e, %Y')
  end

  def create_time
    created_at.strftime('%l:%M %p')
  end

  def update_date
    updated_at.strftime('%b %e, %Y')
  end

  def update_time
    updated_at.strftime('%l:%M %p')
  end
end
