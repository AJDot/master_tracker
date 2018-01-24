class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :skill
  belongs_to :description

  validates :duration, presence: true, numericality: { greater_than: 0, only_integer: true}
  validates :date, presence: true
  validates :category_id, presence: true
  validates :skill_id, presence: true
  validates :description_id, presence: true

  def get_hours_mins(dur)
    match = DURATION_REGEX.match(dur)
    match ? match[2..3] : nil
  end

  def category_id
    self.category.id if self.category
  end

  def category_id=(cat_id)
    self.category = Category.find(cat_id) if cat_id != ""
  end

  def skill_id
    self.skill.id if self.skill
  end

  def skill_id=(skill_id)
    self.skill = Skill.find(skill_id) if skill_id != ""
  end

  def description_id
    self.description.id if self.description
  end

  def description_id=(desc_id)
    self.description = Description.find(desc_id) if desc_id != ""
  end
end
