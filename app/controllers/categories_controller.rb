class CategoriesController < ApplicationController
  def index
    @categories = search(params[:query], {limit: params[:limit]}).map(&:name)
    respond_to do |format|
      format.json do
        render json: @categories
      end
    end
  end

  private

  def search(query, options)
    limit = options[:limit].to_i > 0 ? options[:limit] : nil
    result = Category.where('lower(name) LIKE ?', "%#{query.downcase}%")
    limit ? result.limit(limit) : result
  end
end
