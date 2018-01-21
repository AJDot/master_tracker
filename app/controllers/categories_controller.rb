class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @user = User.find params[:user_id]
  end

  def create
    @category = Category.new(category_params)
    @user = User.find params[:user_id]
    @category.user = @user

    if @category.save
      flash[:success] = "Your category was created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
