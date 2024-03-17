## Назначить незакрытые задачи на случайных попугов
class ReassignTasks < ApplicationInteraction
  def execute
    return errors.add(:base, "У нас не осталось попугов") if User.role_popug.none?

    assigned_tasks = []
    events = []

    popugs_by_id = User.role_popug.pluck(:id, :public_id)

    tasks = Task.not_completed.pluck(:id, :public_id, :subject)

    tasks.each do |id, public_id, subject|
      popug_id, popug_public_id = *popugs_by_id.sample

      assigned_tasks << { id: id, public_id: public_id, subject: subject, assignee_id: popug_id }
      # ну здесь мы делаем вид, что всё ок и у события действительно случился успешный реассайн
      events << Task::Assigned.new({ public_id: public_id, subject: subject, assignee_id: popug_public_id })
    end

    Task.upsert_all(assigned_tasks, unique_by: [:id])

    EDA.stream_batch events
  end

  private

  def random_popug
    User.role_popug.reorder("RANDOM()").first
  end
end