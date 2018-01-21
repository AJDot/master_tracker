class API::V1::SkillsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        skills = search(params[:query], {limit: params[:limit], user_id: params[:user_id]})
        render json: skills
      end
    end
  end

  private

  def search(query, options)
    limit = options[:limit].to_i > 0 ? options[:limit] : nil
    result = Skill.where('lower(name) LIKE ? AND user_id = ?', "%#{query.downcase}%", options[:user_id])
    limit ? result.limit(limit) : result
  end
end
