# frozen_string_literal: true

#
class TaskAddedHandler < ::Handler
  def call
    # TODO: более явно выделить бизнес-логику
    task = Task.create_or_update_from_event(data)

    PricifyTask.run!(task: task)

    UpdateUserBalance.run!(
      transaction_type: "task.assigned",
      user: task.assignee,
      credit: task.assign_price,
      description: "За назначение задачи #{task.public_id}"
    )
  end
end
