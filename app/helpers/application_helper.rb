module ApplicationHelper
  def format_duration(dur)
    hh, mm = dur.to_i.divmod(60)
    format("%2d:%02d", hh, mm)
  end

  def format_entry_date(date)
    date.strftime('%b %e, %Y')
  end
end
