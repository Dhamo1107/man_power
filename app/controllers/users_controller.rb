class UsersController < ApplicationController
  include Pagy::Backend
  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true).includes(:professions))
    @search_url = users_path
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    @users = User.search_by_name(params[:q])
    respond_to do |format|
      format.json { render json: @users }
    end
  end
end
