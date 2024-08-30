class RatingsController < ApplicationController
  before_action :set_task, only: %i[new create]
  before_action :ensure_task_completed, only: %i[new create]

  def new
    @rating = @task.build_rating
  end

  def create
    @rating = @task.build_rating(rating_params)
    if @rating.save
      redirect_to task_path(@task), notice: 'Thank you for your feedback!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def ensure_task_completed
    redirect_to task_path(@task), alert: 'Task must be completed before rating.' unless @task.status == 'completed'
  end

  def rating_params
    params.require(:rating).permit(:rating, :comment)
  end
end
