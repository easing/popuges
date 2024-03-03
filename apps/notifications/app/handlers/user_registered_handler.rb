# frozen_string_literal: true

#
class UserRegisteredHandler < ::Handler
  def call
    user = User.create_with(name: data["name"].to_s, role: data["role"].to_s)
               .create_or_find_by!(id: data["id"])

    Notification.create!(subject: "Новый пользователь: #{user.name}")
  end
end
