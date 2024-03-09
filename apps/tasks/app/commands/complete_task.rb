## Отметить задачу выполненной
class CompleteTask < ApplicationInteraction
  record :task

  def execute
    task.update!(completed_at: Time.current)
    task
  end
end
