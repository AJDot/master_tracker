class SkillsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        @skills = search(params[:query], {limit: params[:limit]})
        render json: @skills
      end
    end
  end

  def new
    @skill = Skill.new
    @user = User.find params[:user_id]
  end

  def create
    @skill = Skill.new(skill_params)
    user = User.find params[:user_id]
    @skill.user = user

    if @skill.save
      flash[:success] = "Your skill was created."
      redirect_to user_path(user)
    else
      render :new
    end
  end

  private

  def search(query, options)
    limit = options[:limit].to_i > 0 ? options[:limit] : nil
    result = Skill.where('lower(name) LIKE ?', "%#{query.downcase}%")
    limit ? result.limit(limit) : result
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
