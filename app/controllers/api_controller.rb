class APIController < ApplicationController
  def index
  end

  def entries
    respond_to do |format|
      format.json do
        render {test: "Did this work?"} 
      end
    end
  end
end
