class SpreadsheetsController < ApplicationController
  def show
    @spreadsheet = Spreadsheet.first
  end

  def update
    respond_to do |format|
      format.js do
        @spreadsheet = Spreadsheet.find(params[:id])
        params[:data].each do |key, value|
          id = value["id"].to_i
          params = value.permit("category", "skill", "description")
          row = Row.find(id)
          row.update(params)
        end
        head :no_content
      end
    end
  end
end
