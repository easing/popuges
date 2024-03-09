# frozen_string_literal: true

#
class TaskAssignedHandler < ::Handler
  def call
    task = Task.create_or_update_from_event(data)

    PricifyTask.run!(task: task) unless task.priced?

    UpdateUserBalance.run!(
      transaction_type: "task.assigned",
      credit: task.assign_price,
      description: "Task ##{task.id} assigned"
    )
  end
end
