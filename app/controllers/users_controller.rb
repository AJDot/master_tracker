class UsersController < ApplicationController
  include ApplicationHelper
  before_action :require_user, only: [:show, :edit, :update, :daily_activity]
  before_action only: [:show, :edit, :update, :daily_activity] do
    require_user_owns_page(params[:id] || params[:user_id])
  end

  def show
    @user = User.find_by username: params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You are registered!"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by username: params[:id]
  end

  def update
    @user = User.find_by username: params[:id]

    if @user.update(user_params)
      flash[:success] = "Your profile was updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def daily_activity
    @user = User.find_by username: params[:user_id]
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
