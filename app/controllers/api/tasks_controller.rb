class Api::TasksController < ApplicationController
  before_action :find_task, only: [:update, :destroy ]
  before_action :find_all, only: [:index, :check_all, :uncheck_all]
  def index
    render json: @tasks
  end

  def create
    task = Task.create(create_params.merge!({done: false}))
    if task.save
      render json: task, status: :created
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end  
  
  def update
    if @task.update(update_params)
      render json: @task
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end 

  def check_all
    if @tasks.update_all done: true
      head :no_content
      return true;
    else
      render json: tasks.map{|task| task.errors.full_messages}, status: :unprocessable_entity
      return false;    
    end
  end

  def uncheck_all
    if @tasks.update_all done: false
      head :no_content
      return true;
    else
      render json: tasks.map{ |task| task.errors.full_messages}, status: :unprocessable_entity
      return false;
    end
  end

  def destroy
    if @task.destroy
      head :no_content
      return true;
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
      return false;
    end
  end

  def destroy_checked
    tasksDone = Task.where(done: true)
    if tasksDone.destroy_all
      head :no_content
      return true;
    else
      render json: tasksDone.map{ |taskDone| taskDone.errors.full_messages} ,status: :unprocessable_entity
      return false;
    end
  end

  private

  def create_params
    params.require(:task).permit(:description)
  end

  def update_params
    params.require(:task).permit(:description, :done)
  end 

  def find_task
    @task = Task.find(params[:id]);
  end

  def find_all
    @tasks = Task.all
  end
end
