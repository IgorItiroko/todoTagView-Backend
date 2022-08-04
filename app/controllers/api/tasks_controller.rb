class Api::TasksController < ApplicationController
  before_action :find_task, only: [:update, :destroy ]

  def index
    render json: Task.all
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

  def toggle_all_done
    Task.where(done: !:done).update_all(done: :done)
    head :no_content
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
    Task.where(done:true).destroy_all
      head :no_content
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

end
