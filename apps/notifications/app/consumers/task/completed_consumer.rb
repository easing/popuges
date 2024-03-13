# frozen_string_literal: true

#
class Task::CompletedConsumer < EDA::Consumer
  version 1 do
    Notification.transaction do
      user = User.create_or_update_from_event("role" => "", "name" => "", "public_id" => data["assignee_id"])
      Notification.create!(subject: "Вы закрыли задачу #{data["public_id"]}", user: user)
      Notification.create!(subject: "Задача выполнена #{data["public_id"]}")
    end
  end
end
