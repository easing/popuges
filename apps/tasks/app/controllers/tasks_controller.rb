class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @grid = TasksGrid.new { @tasks.includes(:assignee) }
    @not_completed_tasks = @tasks.not_completed
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

  def reassign
    ReassignTasks.run!
    redirect_back fallback_location: tasks_path
  end

  def mass_complete
    Task::MassComplete.run!
    redirect_back fallback_location: tasks_path
  end
  def mass_create
    Task::MassCreate.run!
    redirect_back fallback_location: tasks_path
  end
end