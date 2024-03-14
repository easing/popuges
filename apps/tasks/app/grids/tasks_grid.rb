class TasksGrid < ApplicationGrid
  scope { Task }

  column :id

  column :jira_id, html: true do |task|
    content_tag(:code, task.jira_id)
  end

  column :subject

  column :assignee, html: true do |record|
    link_to record.assignee.display_name, record
  end

  column :completed, html: true do |task|
    if task.completed?
      task.completed_at
    else
      form_tag complete_task_path(task), method: :patch do |f|
        submit_tag "Завершить"
      end
    end
  end


end