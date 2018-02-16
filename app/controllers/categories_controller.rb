class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action only: [:new, :create, :edit, :update] do
    require_user_owns_page(params[:user_id])
  end

  def new
    @category = Category.new
    @user = User.find_by username: params[:user_id]
  end

  def create
    @category = Category.new(category_params)
    @user = User.find_by username: params[:user_id]
    @category.user = @user

    if @category.save
      flash[:success] = "Your category was created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by username: params[:user_id]
    @category = Category.find_by token: params[:id]
  end

  def update
    @user = User.find_by username: params[:user_id]
    @category = Category.find_by token: params[:id]

    if @category.update(category_params)
      flash[:success] = "Category updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
