class DescriptionsController < ApplicationController
  def index
    @descriptions = search(params[:query], {limit: params[:limit]}).map(&:name)
    respond_to do |format|
      format.json do
        render json: @descriptions
      end
    end
  end

  def new
    @description = Description.new
  end

  def create
    @description = Description.new(description_params)
    # Assign correct user after authentication
    @description.user = User.first

    if @description.save
      flash[:success] = "Your description was created."
      redirect_to root_path
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
