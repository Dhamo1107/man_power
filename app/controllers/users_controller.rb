class UsersController < ApplicationController
  include Pagy::Backend
  def index
    @q = User.exclude_current_user(current_user).ransack(params[:q])
    @pagy, @users = pagy(@q.result(distinct: true).includes(:professions))
    @search_url = users_path
  end

  def show
    @user = User.find(params[:id])
    @average_rating = User.average_rating(@user.id)
    @user_rank = @user.user_rank
    @leaderboard_score = @user.leaderboard_score
  end

  def search
    @users = User.search_by_name(params[:q])
    respond_to do |format|
      format.json { render json: @users }
    end
  end
end
