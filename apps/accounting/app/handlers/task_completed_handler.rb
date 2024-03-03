# frozen_string_literal: true

##
class TaskCompletedHandler < ::Handler
  def call
    Task.transaction do
      task = Task.create_or_update_from_event(data)

      UpdateUserBalance.run!(
        user: task.assigned_to,
        debit: task.complete_price,
        description: "Task ##{task.id} completed"
      )
    end
  end
end
