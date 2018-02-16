class SkillsController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]

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

  def edit
    @user = User.find params[:user_id]
    @skill = Skill.find_by token: params[:id]
  end

  def update
    @user = User.find params[:user_id]
    @skill = Skill.find_by token: params[:id]

    if @skill.update(skill_params)
      flash[:success] = "Skill updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def skill_params
    params.require(:skill).permit(:name)
  end
end
