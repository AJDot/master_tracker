class SpreadsheetsController < ApplicationController
  before_action :require_user, only: [:show, :new, :create, :edit, :update]
  before_action  only: [:show, :new, :create, :edit, :update] do
    require_user_owns_page(params[:user_id])
  end

  def show
    @user = User.find_by username: params[:user_id]
    @spreadsheet = Spreadsheet.find_by token: params[:id]
  end

  def new
    @user = User.find_by username: params[:user_id]
    @spreadsheet = Spreadsheet.new
  end

  def create
    @user = User.find_by username: params[:user_id]
    @spreadsheet = Spreadsheet.new(spreadsheet_params)
    @spreadsheet.user = @user

    if @spreadsheet.save
      flash[:success] = "Your spreadsheet was created."
      redirect_to user_spreadsheet_path(@user, @spreadsheet)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by username: params[:user_id]
    @spreadsheet = Spreadsheet.find_by token: params[:id]
  end

  def update
    @user = User.find_by username: params[:user_id]
    @spreadsheet = Spreadsheet.find_by token: params[:id]

    if @spreadsheet.update(spreadsheet_params)
      flash[:success] = 'Spreadsheet updated.'
      redirect_to user_spreadsheet_path(@user, @spreadsheet)
    else
      render :edit
    end
  end

  private

  def spreadsheet_params
    params.require(:spreadsheet).permit(:name)
  end
end
