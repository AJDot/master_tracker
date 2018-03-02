class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :sum_duration, :format_duration
  helper_method :format_entry_date, :format_spreadsheet_date

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to login_path
    end
  end

  def require_user_owns_page(user_id)
    user = User.find_by username: user_id
    if user != current_user
      flash[:danger] = "That page doesn't exist. Here's your profile."
      redirect_to user_path(current_user)
    end
  end

  def sum_duration(category, skill, description)
    entries = Entry.where(category: category, skill: skill, description: description)
    durations = entries.pluck(:duration).map(&:to_i)
    durations.reduce(:+)
  end

  def format_duration(dur)
    hh, mm = dur.to_i.divmod(60)
    format("%2d:%02d", hh, mm)
  end

  def format_entry_date(date)
    date.strftime('%b %e, %Y')
  end

  def parse_stopwatch_duration(stopwatch_duration)
    match = stopwatch_duration.match /(\d+):(\d+):(\d+)/
    hours = match[1].to_i
    mins = match[2].to_i
    secs = match[3].to_i
    (hours * 60 + mins + secs.to_f / 60).round
  end
end
