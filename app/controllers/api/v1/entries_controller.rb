class API::V1::EntriesController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        category = Category.find_by token: params[:category]["id"]
        skill = Skill.find_by token: params[:skill]["id"]
        description = Description.find_by token: params[:description]["id"]
        user = User.find(params[:user_id])
        entries = entries_by_date_range(category, skill, description, user)
        render json: entries
      end
    end
  end

  private

  def select_entry_params
    params.permit(:category, :skill, :description)
  end

  def entries_by_date_range(category, skill, description, user)
    today = Date.today
    entries = {}
    entries["all_time"] = Entry.where(user: user, category: category, skill: skill, description: description).where("date <= ?", Time.now)
    entries["today"] = Entry.where(user: user, category: category, skill: skill, description: description, date: (Date.today.to_s..Time.now))
    entries["yesterday"] = Entry.where(user: user, category: category, skill: skill, description: description, date: ((today - 1.day).to_s...Date.today.to_s))
    entries["this_month"] = Entry.where(user: user, category: category, skill: skill, description: description, date: (today.beginning_of_month..Time.now))
    entries
  end
end
