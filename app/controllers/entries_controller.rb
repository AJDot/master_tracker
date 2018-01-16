class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    # Assign correct user after authentication
    @entry.user = User.first

    # @category = Category.find_by name: params[:entry][:category]
    # @skill = Skill.find_by name: params[:entry][:skill]
    # @description = Description.find_by name: params[:entry][:description]
    # @entry.assign_attributes category: @category, skill: @skill, description: @description, user: User.first

    if @entry.save
      flash[:success] = "Your entry was created."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:format_duration, :date, :category_name, :skill_name, :description_name)
  end
end
