# frozen_string_literal: true

#
class Task::AssignedConsumer < EDA::Consumer
  version 1 do
    Notification.transaction do
      user = User.create_or_update_from_event(role: "", name: "", public_id: data["assignee_id"])
      Notification.create!(subject: "Вам добавлена задача #{data["id"]}", user: user)
    end
  end
end
