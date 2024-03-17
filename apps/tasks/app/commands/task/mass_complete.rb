class Task::MassComplete < ApplicationInteraction
  def execute
    tasks = Task.not_completed
                .includes(:assignee)
                .order(created_at: :desc)
                .limit((Task.not_completed.count / rand(2..10)).to_i)

    tasks.update_all(completed_at: Time.current)

    events = tasks.map do |task|
      Task::Completed.new({
                            public_id: task.public_id,
                            assignee_id: task.assignee.public_id,
                            subject: task.subject
                          })
    end

    EDA.stream_batch events
  end
end