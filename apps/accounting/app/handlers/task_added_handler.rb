# frozen_string_literal: true

#
class TaskAddedHandler < ::Handler
  def call
    task = nil

    # TODO: более явно выделить бизнес-логику
    Task.transaction do
      task = Task.create_or_update_from_event(data)
      task.update!(assign_price: rand(10..20), complete_price: rand(20..40)) if task.assign_price.blank? && task.complete_price.blank?
    end

    UpdateUserBalance.run!(
      user: task.attributes["assigned_to_id"],
      credit: task.attributes["assign_price"],
      description: "Task ##{task.id} assigned"
    )
  end
end
