class Task::MassCreate < ApplicationInteraction
  def execute

    popugs_by_id = User.role_popug.pluck(:id, :public_id)

    tasks = []
    events = []

    popugs_by_id.each do |user_id, user_public_id|

      task_data = {
        assignee_id: user_id,
        jira_id: SecureRandom.hex(2),
        subject: SecureRandom.hex,
        public_id: SecureRandom.uuid,
        created_at: Time.current,
        updated_at: Time.current
      }

      event_data = { **task_data, assignee_id: user_public_id }

      tasks << task_data

      events << Task::Created.new(event_data)
      events << Task::Added.new(event_data)
    end

    Task.insert_all(tasks)

    EDA.stream_batch events
  end
end