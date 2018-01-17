class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :sum_duration, :format_duration

  def sum_duration(category, skill, description)
    entries = Entry.where(category: category, skill: skill, description: description)
    durations = entries.pluck(:duration).map(&:to_i)
    durations.reduce(:+)
  end

  def format_duration(dur)
    hh, mm = dur.to_i.divmod(60)
    "#{hh}:#{mm}"
  end
end
