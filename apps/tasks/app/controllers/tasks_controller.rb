class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    AddTask.run!
    redirect_back fallback_location: tasks_path
  end

  private

  def permitted_params
    params.require(:task).permit(:subject)
  end
end