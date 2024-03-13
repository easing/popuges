class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @tasks = @tasks.includes(:assignee)
  end

  def show
  end

  def create
    task = AddTask.run!
    EDA.stream Task::Added.new(task.as_event_data)

    redirect_back fallback_location: tasks_path
  end

  def complete
    task = CompleteTask.run!(task: params[:id])
    EDA.stream Task::Completed.new(task.as_event_data)

    redirect_back fallback_location: tasks_path
  end
end