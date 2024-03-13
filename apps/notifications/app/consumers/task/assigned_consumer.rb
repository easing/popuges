# frozen_string_literal: true

#
class Task::AssignedConsumer < EDA::Consumer
  version 1 do
    Notification.transaction do
      user = User.create_or_update_from_event("public_id" => event.data["assignee_id"])
      Notification.create!(subject: "На вас упала задача #{data["subject"]} (#{data["public_id"]})", user: user)
    end
  end
end
