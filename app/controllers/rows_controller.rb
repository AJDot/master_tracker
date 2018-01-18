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
end
