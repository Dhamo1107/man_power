class UsersController < ApplicationController
  include Pagy::Backend
  def index
    @pagy, @users = pagy(User.includes(:professions))
  end

  def show
    @user = User.find(params[:id])
  end
end
