class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :sum_duration, :format_duration
  helper_method :format_entry_date

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
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
end
