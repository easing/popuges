# frozen_string_literal: true

##
class UserRoleChangedHandler < Handler
  def call
    user = User.create_or_update_from_event(data)

    create_and_complete_gift_task(user) if user.role_popug?
  end

  private
  def create_and_complete_gift_task(user)
    Task.transaction do
      task = Task.create!(subject: "Задачка в подарок для нашего попуга", assignee: user)
      CompleteTask.run!(task: task)
    end

    stream TaskAdded, task.as_event_data
    stream TaskCompleted, task.as_event_data
  end
end
