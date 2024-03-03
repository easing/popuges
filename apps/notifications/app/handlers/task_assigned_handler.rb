# frozen_string_literal: true

#
class TaskAssignedHandler < ::Handler
  def call
    return if data["assigned_to_id"].blank?

    Notification.transaction do
      user = User.create_with(role: "").find_or_create_by!(id: data["assigned_to_id"])
      Notification.create!(subject: "Вам добавлена задача #{data["id"]}", user: user)
    end
  end
end
