class DescriptionsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        @descriptions = search(params[:query], {limit: params[:limit]})
        render json: @descriptions
      end
    end
  end

  def new
    @description = Description.new
    @user = User.find params[:user_id]
  end

  def create
    @description = Description.new(description_params)
    user = User.find params[:user_id]
    @description.user = user

    if @description.save
      flash[:success] = "Your description was created."
      redirect_to user_path(user)
    else
      render :new
    end
  end

  private

  def search(query, options)
    limit = options[:limit].to_i > 0 ? options[:limit] : nil
    result = Description.where('lower(name) LIKE ?', "%#{query.downcase}%")
    limit ? result.limit(limit) : result
  end

  private

  def description_params
    params.require(:description).permit(:name)
  end
end
