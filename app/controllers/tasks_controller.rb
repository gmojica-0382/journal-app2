class TasksController < ApplicationController
  before_action :set_category, except: %i[ index ]
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
  # Note: If you don't use the has_many <method_name>, :through <method_name> in models,
  # do the comment out codes below
    # @tasks = []
    # current_user.categories.each do |category|
    #   category.tasks.each do |task|
    #     @tasks << task
    #   end
    # end
    @date_today = Date.current.strftime('%b %e, %Y')
    # @overdue = current_user.tasks.where("date < ? ", @date_today)
    # @overdue = []
    # current_user.tasks.each do |task|
    #   @overdue << task
    # end 

    day = params[:day]
    if day
      @tasks = current_user.tasks.where(:date => day)
    else
      @tasks = current_user.tasks
    end
  end

  def show
  end

  def new
    @task = @category.tasks.build
  end

  def edit
  end

  def create
    @task = @category.tasks.build(task_params)

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
    @category = current_user.categories.find_by_id(params[:category_id])
    
    if @category.nil?
      redirect_to root_url, notice: "No category id #{params[:category_id]} found" 
    end
  end

  def set_task
    @task = @category.tasks.find_by_id(params[:id])
    if @task.nil?
      redirect_to category_url(@category), notice: "No task id #{params[:id]} found" 
    end
  end

  def task_params
    params.require(:task).permit(:title, :notes, :date, :completed)
  end
end
