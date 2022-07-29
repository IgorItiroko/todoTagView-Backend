class Api::TasksController < ApplicationController
  def index
    render json: Task.all
  end

  def create
    task = Task.create(task_params)
    render json: task
  end  
  
  def update
    task = Task.find(params[:id])
    task.description = params[:description]
    task.done = params[:done]
    task.save
  end 

  def check_all
    Task.update_all done: true
  end

  def uncheck_all
    Task.update_all done: false
  end

  def destroy
    Task.destroy(params[:id])
  end

  def destroy_checked
    Task.where(:done => true).delete_all
  end

  private

  def task_params
    params.require(:task).permit(:description, :done)
  end

end
