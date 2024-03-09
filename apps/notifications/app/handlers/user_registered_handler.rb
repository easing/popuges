# frozen_string_literal: true

#
class UserRegisteredHandler < ::Handler
  def call
    user = User.create_or_update_from_event(data)
    Notification.create!(subject: "Новый пользователь: #{user.name}")
  end
end
