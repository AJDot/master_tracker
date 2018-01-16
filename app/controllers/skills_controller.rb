class SkillsController < ApplicationController
  def index
    @skills = search(params[:query], {limit: params[:limit]}).map(&:name)
    respond_to do |format|
      format.json do
        render json: @skills
      end
    end
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    # Assign correct user after authentication
    @skill.user = User.first

    if @skill.save
      flash[:success] = "Your skill was created."
      redirect_to root_path
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
