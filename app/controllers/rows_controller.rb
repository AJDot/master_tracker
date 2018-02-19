class RowsController < ApplicationController
  before_action :require_user
  before_action do
    require_user_owns_page(params[:user_id])
  end

  def create
    respond_to do |format|
      format.js do
        @user = User.find_by username: params[:user_id]
        @spreadsheet = Spreadsheet.find_by token: params[:spreadsheet_id]

        if @spreadsheet.create_row
          render :add
        else
          flash[:danger] = 'You must have at least one category, skill, and description to create rows. To create a category, skill, or description, use the "New" menu.'
          render :no_traits
        end
      end
    end
  end

  def update
    respond_to do |format|
      format.js do
        @spreadsheet = Spreadsheet.find_by token: params[:id]
        params[:data].each do |key, value|
          id = value["id"].to_i
          category = Category.find_by token: value["category_id"]
          skill = Skill.find_by token: value["skill_id"]
          description = Description.find_by token: value["description_id"]
          row = Row.find(id)
          row.update(category: category, skill: skill, description: description)
        end
        @spreadsheet.updated_at = DateTime.now.to_s
        @spreadsheet.save
        head :no_content
      end
    end
  end

  def destroy
    @user = User.find_by username: params[:user_id]
    @spreadsheet = Spreadsheet.find_by token: params[:spreadsheet_id]
    @spreadsheet.rows.last.destroy unless @spreadsheet.rows.empty?
    respond_to do |format|
      format.html do
        redirect_to user_spreadsheet_path @user, @spreadsheet
      end
      format.js do
        render :destroy
      end
    end
  end
end
