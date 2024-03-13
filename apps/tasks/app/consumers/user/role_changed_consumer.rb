# frozen_string_literal: true

##
class User::RoleChangedConsumer < EDA::Consumer
  version 1 do
    user = User.create_or_update_from_event(event.data)
    create_and_complete_gift_task(user) if user.role_popug?
  end

  private

  def create_and_complete_gift_task(user)
    task = nil

    Task.transaction do
      task = Task.create!(subject: "Задачка в подарок для нашего попуга", assignee: user)
      CompleteTask.run!(task: task)
    end

    return unless task&.persisted?

    EDA.stream Task::Added.new(task.as_event_data)
    EDA.stream Task::Completed.new(task.as_event_data)
  end
end
