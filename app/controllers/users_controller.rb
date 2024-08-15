class UsersController < ApplicationController
  include Pagy::Backend
  def index
    @pagy, @users = pagy(User.all)
  end

  def show
    @user = User.find(params[:id])
  end
end
