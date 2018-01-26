class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]

  def new
    redirect_to user_path(current_user) if logged_in?
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}."
      redirect_to user_path(user)
    else
      flash[:danger] = "There is something wrong with your name or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end
end
