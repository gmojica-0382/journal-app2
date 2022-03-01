class TasksController < ApplicationController
  before_action :set_category
  before_action :set_task, only: %i[ show edit update destroy ]

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @category.tasks.new(task_params)

    if @task.save
      redirect_to category_url(@category), notice: "Task was successfully created."
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to category_url(@category),  notice: "Task was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to category_url(@category), notice: "Task was successfully destroyed."
  end

  private
  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :notes, :date, :completed)
  end
end
