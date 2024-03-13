# frozen_string_literal: true

#
class Task::AssignedConsumer < EDA::Consumer
  version 1 do
    task = Task.create_or_update_from_event(event.data)

    PricifyTask.run!(task: task) unless task.priced?

    User::ChangeBalance.run!(
      transaction_type: "task.assigned",
      user: task.assignee,
      credit: task.assign_price,
      description: "За выпадание задачи ##{task.public_id}"
    )
  end
end
