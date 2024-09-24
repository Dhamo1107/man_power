class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[ show edit update destroy ]
  before_action :authorize_discussion, only: [:edit, :update, :destroy]

  def index
    @discussions = Discussion.includes(:user).all.order(updated_at: :desc)
  end

  def show
    @comments = @discussion.comments.includes(:user).order(updated_at: :asc)
    @comment = Comment.new
  end

  def new
    @discussion = Discussion.new
  end

  def edit
  end

  def create
    @discussion = current_user.discussions.build(discussion_params)
    if @discussion.save
      redirect_to discussion_url(@discussion), notice: "Discussion was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to discussion_url(@discussion), notice: "Discussion was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @discussion.destroy
    redirect_to discussions_url, notice: "Discussion was successfully destroyed."
  end

  private
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :body, :user_id)
  end

  def authorize_discussion
    authorize @discussion
  end
end
