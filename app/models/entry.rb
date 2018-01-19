class Entry < ActiveRecord::Base
  DURATION_REGEX = /\A((0?[0-9]|1[0-9]|2[0-3]):([0-5]?[0-9]))\z/

  belongs_to :user
  belongs_to :category
  belongs_to :skill
  belongs_to :description

  validates :format_duration, format: { with: DURATION_REGEX, message: "incorrect format (hh:mm)"}
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :date, presence: true

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
end
