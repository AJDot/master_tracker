class Entry < ActiveRecord::Base
  DURATION_REGEX = /\A((\d+):([0-5]?[0-9]))\z/

  belongs_to :user
  belongs_to :category
  belongs_to :skill
  belongs_to :description

  validates :format_duration, format: { with: DURATION_REGEX, message: "incorrect format (hh:mm)"}
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true
  validates :category_id, presence: true
  validates :skill_id, presence: true
  validates :description_id, presence: true

  def format_duration
    return self.duration if self.duration.nil?
    mm = self.duration
    hh, mm = mm.divmod(60)
    "#{hh}:#{mm}"
  end

  def format_duration=(hhmm)
    return unless get_hours_mins(hhmm)
    h, m = get_hours_mins(hhmm).map(&:to_i)
    dur = h * 60 + m
    self.duration = dur
  end

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
