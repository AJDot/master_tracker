class EntriesController < ApplicationController
  before_action :require_user, only: [:index, :new, :create, :edit, :update]

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
      redirect_to user_entries_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:user_id]
    @entry = Entry.find params[:id]
  end

  def update
    @user = User.find params[:user_id]
    @entry = Entry.find params[:id]

    if @entry.update(entry_params)
      flash[:success] = "Entry updated."
      redirect_to user_entries_path(@user)
    else
      render :edit
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:duration, :date, :category_id, :skill_id, :description_id)
  end
end
