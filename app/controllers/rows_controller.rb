class RowsController < ApplicationController
  def create
    respond_to do |format|
      format.js do
        @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
        @spreadsheet.rows << Row.new

        render :add
      end
    end
  end

  def update
    respond_to do |format|
      format.js do
        @spreadsheet = Spreadsheet.find(params[:spreadsheet_id])
        @row = Row.find(params[:id])
        @row.assign_attributes(params[:data].permit("category", "skill", "description"))
        @row.save
        head :no_content
      end
    end
  end
end
