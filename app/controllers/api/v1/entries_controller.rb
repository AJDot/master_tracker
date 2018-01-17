class API::V1::EntriesController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        category = Category.find_by name: params[:category]
        skill = Skill.find_by name: params[:skill]
        description = Description.find_by name: params[:description]
        entries = Entry.where(category: category, skill: skill, description: description)
        render json: entries
      end
    end
  end

  private

  def select_entry_params
    params.permit(:category, :skill, :description)
  end
end
