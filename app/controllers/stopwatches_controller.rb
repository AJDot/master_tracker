class StopwatchesController < ApplicationController
  before_action :require_user
  before_action  only: [:index, :new, :create, :edit, :update] do
    require_user_owns_page(params[:user_id])
  end

  def index
    @user = current_user
  end
end
