class CategoriesController < ApplicationController
  def index
    @categories = search(params[:query], {limit: params[:limit]}).map(&:name)
    respond_to do |format|
      format.json do
        render json: @categories
      end
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = User.first

    if @category.save
      flash[:success] = "Your category was created."
      redirect_to root_path
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
