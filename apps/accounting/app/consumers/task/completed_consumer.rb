# frozen_string_literal: true

##
class Task::CompletedConsumer < EDA::Consumer
  version 1 do
    task = Task.create_or_update_from_event(data)

    UpdateUserBalance.run!(
      transaction_type: "task.completed",
      user: task.assignee,
      debit: task.complete_price,
      description: "За выполнение задачи ##{task.public_id}"
    )
  end
end
