class SkillsController < ApplicationController
  def new
    @skill = Skill.new
    @user = User.find params[:user_id]
  end

  def create
    @skill = Skill.new(skill_params)
    @user = User.find params[:user_id]
    @skill.user = @user

    if @skill.save
      flash[:success] = "Your skill was created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:name)
  end
end
