class SpreadsheetsController < ApplicationController
  def show
    @spreadsheet = Spreadsheet.find params[:id]
    @user = User.find params[:user_id]
  end

  def new
    @user = User.find params[:user_id]
    @spreadsheet = Spreadsheet.new
  end

  def create
    @user = User.find params[:user_id]
    @spreadsheet = Spreadsheet.new(spreadsheet_params)
    @spreadsheet.user = @user

    if @spreadsheet.save
      flash[:success] = "Your spreadsheet was created."
      redirect_to user_spreadsheet_path(@user, @spreadsheet)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      format.js do
        @spreadsheet = Spreadsheet.find(params[:id])
        params[:data].each do |key, value|
          id = value["id"].to_i
          params = value.permit("category_id", "skill_id", "description_id")
          row = Row.find(id)
          row.update(params)
        end
        head :no_content
      end
    end
  end

  private

  def spreadsheet_params
    params.require(:spreadsheet).permit(:name)
  end
end
