class CategoriesController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        @categories = search(params[:query], {limit: params[:limit]})
        render json: @categories
      end
    end
  end

  def new
    @category = Category.new
    @user = User.find params[:user_id]
  end

  def create
    @category = Category.new(category_params)
    user = User.find params[:user_id]
    @category.user = user

    if @category.save
      flash[:success] = "Your category was created."
      redirect_to user_path(user)
    else
      render :new
    end
  end

  private

  def search(query, options)
    limit = options[:limit].to_i > 0 ? options[:limit] : nil
    result = Category.where('lower(name) LIKE ?', "%#{query.downcase}%")
    limit ? result.limit(limit) : result
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
