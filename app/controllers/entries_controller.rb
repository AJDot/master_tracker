class EntriesController < ApplicationController
  before_action :require_user, only: [:index, :new, :create]

  def index
    @user = User.find params[:user_id]
    @entries = @user.entries
  end

  def new
    @entry = Entry.new
    @user = User.find params[:user_id]
  end

  def create
    @entry = Entry.new(entry_params)
    @user = User.find params[:user_id]
    if @user.entries << @entry
      flash[:success] = "Your entry was created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:format_duration, :date, :category_id, :skill_id, :description_id)
  end
end
