class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @created_tasks = current_user.created_tasks.order(created_at: :desc)
    @assigned_tasks = current_user.assigned_tasks.order(created_at: :desc)
  end

  def new
    @task = Task.new
    @assignee = User.find(params[:user_id])
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
