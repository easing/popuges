## Назначить незакрытые задачи на случайных попугов
class ReassignTasks < ApplicationInteraction
  def execute
    return errors.add(:base, "У нас не осталось попугов") if User.role_popug.none?

    assigned_tasks = []

    Task.not_completed.find_each do |task|
      task.update!(assignee: random_popug)

      assigned_tasks << task if task.saved_change_to_assignee_id?
    end

    TaskAssigned.stream_batch assigned_tasks.map(&:as_event_data)
  end

  private

  def random_popug
    User.role_popug.reorder("RANDOM()").first
  end
end