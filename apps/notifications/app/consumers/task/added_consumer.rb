# frozen_string_literal: true

#
class Task::AddedConsumer < EDA::Consumer
  version 1 do
    Notification.transaction do
      user = User.create_or_update_from_event("public_id" => data["assignee_id"])
      Notification.create!(subject: "Вам добавлена задача #{data["public_id"]}", user: user)
    end
  end
end
