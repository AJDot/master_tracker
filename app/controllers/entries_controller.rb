class EntriesController < ApplicationController
  before_action :require_user, only: [:index, :new, :create, :edit, :update, :create_from_stopwatch]
  before_action  only: [:index, :new, :create, :edit, :update, :create_from_stopwatch] do
    require_user_owns_page(params[:user_id])
  end

  def index
    @user = User.find_by username: params[:user_id]
    @entries = @user.entries
  end

  def new
    @entry = Entry.new
    @user = User.find_by username: params[:user_id]
  end

  def create
    @entry = Entry.new(entry_params)
    @user = User.find_by username: params[:user_id]
    if @user.entries << @entry
      flash[:success] = "Your entry was created."
      redirect_to user_entries_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by username: params[:user_id]
    @entry = Entry.find_by token: params[:id]
  end

  def update
    @user = User.find_by username: params[:user_id]
    @entry = Entry.find_by token: params[:id]

    if @entry.update(entry_params)
      flash[:success] = "Entry updated."
      redirect_to user_entries_path(@user)
    else
      render :edit
    end
  end

  def create_from_stopwatch
    @row_num = params[:row_num]
    @entry = new_entry_from_stopwatch_params
    respond_to do |format|
      if @entry.save
        format.js do
          render :create_from_stopwatch
        end
      else
        format.js do
          render :create_from_stopwatch_fail
        end
      end
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:duration, :date, :category_id, :skill_id, :description_id)
  end

  def new_entry_from_stopwatch_params
    mins = parse_stopwatch_duration(params[:entry][:duration])
    category = Category.find_by token: params[:entry][:category_id]
    skill = Skill.find_by token: params[:entry][:skill_id]
    description = Description.find_by token: params[:entry][:description_id]
    Entry.new(user: current_user, category: category, skill: skill, description: description, duration: mins, date: Date.today.to_s)
  end
end
