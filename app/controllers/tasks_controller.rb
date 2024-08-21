class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @created_tasks = current_user.created_tasks.order(created_at: :desc)
    @assigned_tasks = current_user.assigned_tasks.order(created_at: :desc)
  end

  def new
    @task = Task.new
    if params[:user_id].present?
      if params[:user_id].to_i == current_user.id
        flash[:alert] = "You cannot create a task for yourself."
        redirect_to users_path and return
      else
        # If the user_id is valid and not the current user, assign it to @assignee
        @assignee = User.find(params[:user_id])
      end
    else
      flash[:alert] = "No user selected for the task."
      redirect_to users_path and return
    end
  end

  def create
    @task = current_user.created_tasks.build(task_params)
    if @task.save
      redirect_to task_path(@task), notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if @task.assigned_to_user_id == current_user.id && @task.status == 'created'
      @task.update(status: 'viewed')
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully deleted.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :assigned_to_user_id, :status)
  end
end
