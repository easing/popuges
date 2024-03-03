class AssignTask < ApplicationInteraction
  record :user

  # @return [Task]
  def execute
    task = Task.random_task
    return unless task

    task.update!(assigned_to: user)

    stream TaskAssigned, task

    task
  end
end