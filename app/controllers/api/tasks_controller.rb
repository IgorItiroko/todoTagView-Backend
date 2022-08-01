class Api::TasksController < ApplicationController
  def index
    render json: Task.all
  end

  def create
    task = Task.create(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end  
  
  def update
    task = Task.find(params[:id])
    task.description = params[:description]
    task.done = params[:done]
    if task.save
      render json: task, status: :ok
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end 

  def check_all
    tasks = Task.all
    if tasks.update_all done: true
      head :no_content
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def uncheck_all
    tasks = Task.all
    if tasks.update_all done: false
      head :no_content
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.destroy
      head :no_content
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy_checked
    tasksDone = Task.where(done: true)
    if tasksDone.destroy_all
      head :no_content
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :done)
  end

end
