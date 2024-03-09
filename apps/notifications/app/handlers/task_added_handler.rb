# frozen_string_literal: true

#
class TaskAddedHandler < ::Handler
  def call
    return if data["assignee_id"].blank?

    Notification.transaction do
      user = User.create_or_update_from_event("role" => "", "name" => "", "public_id" => data["assignee_id"])
      Notification.create!(subject: "Вам добавлена задача #{data["public_id"]}", user: user)
    end
  end
end
