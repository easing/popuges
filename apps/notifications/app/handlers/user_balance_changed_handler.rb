# frozen_string_literal: true

#
class UserBalanceChangedHandler < ::Handler
  def call
    return if data["user_id"].blank?

    Notification.transaction do
      user = User.create_or_update_from_event("public_id" => data["user_id"])
      Notification.create!(subject: "У вас изменился баланс: #{data.slice("debit", "credit").inspect}", user: user)
    end
  end
end
