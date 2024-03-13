# frozen_string_literal: true

#
class Task::AddedConsumer < EDA::Consumer
  version 1 do

    task = Task.create_or_update_from_event(data)

    Task::Pricify.run!(task: task)

    User::UpdateBalance.run!(
      transaction_type: "task.assigned",
      user: task.assignee,
      credit: task.assign_price,
      description: "За назначение задачи #{task.public_id}"
    )
  end
end
