class API::V1::DescriptionsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        user = User.find_by username: params[:user_id]
        descriptions = search(params[:query], { limit: params[:limit], user_id: user.id })
        render json: descriptions
      end
    end
  end

  private

  def search(query, options)
    limit = options[:limit].to_i > 0 ? options[:limit] : nil
    result = Description.where('lower(name) LIKE ? AND user_id = ?', "%#{query.downcase}%", options[:user_id])
    limit ? result.limit(limit) : result
  end
end
