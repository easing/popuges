# frozen_string_literal: true

#
class User::RegisteredConsumer < EDA::Consumer
  def call
    user = User.create_or_update_from_event(data)
    Notification.create!(subject: "У нас новый пользователь: #{user.name}")
  end
end
