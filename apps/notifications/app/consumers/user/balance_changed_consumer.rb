# frozen_string_literal: true

#
class User::BalanceChangedConsumer < EDA::Consumer
  version 1 do |event|
    Notification.transaction do
      user = User.create_or_update_from_event("public_id" => event.data["user_id"])
      Notification.create!(subject: "У вас изменился баланс: #{data.slice("debit", "credit").inspect}", user: user)
    end
  end
end
