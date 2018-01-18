class SpreadsheetsController < ApplicationController
  def show
    @spreadsheet = Spreadsheet.first
  end
end
