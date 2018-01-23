class RowsController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    respond_to do |format|
      format.js do
        @user = User.find params[:user_id]
        @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])

        category = @user.categories.first
        skill = @user.skills.first
        description = @user.descriptions.first

        if category && skill && description
          @spreadsheet.rows << Row.new(
            category: @user.categories.first,
            skill: @user.skills.first,
            description: @user.descriptions.first
          )

          render :add
        else
          flash[:danger] = 'You must have at least one category, skill, and description to create rows. To create a category, skill, or description, use the "New" menu.'
          render :no_traits
        end
      end
    end
  end

  def destroy
    @user = User.find params[:user_id]
    @spreadsheet = Spreadsheet.find(params[:spreadsheet_id]);
    @spreadsheet.rows.last.destroy
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
