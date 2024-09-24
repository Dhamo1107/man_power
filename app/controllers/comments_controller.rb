class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ edit update destroy ]
  before_action :set_discussion, only: %i[ create ]
  before_action :authorize_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @discussion.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @discussion, notice: 'Comment was successfully created.'
    else
      @comments = @discussion.comments.order(created_at: :asc)
      render 'discussions/show'
    end
  end

  def edit
    @discussion = Discussion.find(params[:discussion_id])
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.discussion, notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    discussion = @comment.discussion
    @comment.destroy
    redirect_to discussion, notice: "Comment was successfully destroyed."
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :discussion_id, :user_id)
  end

  def authorize_comment
    authorize @comment
  end
end