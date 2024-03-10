# frozen_string_literal: true

#
class BillingCycleClosedHandler < ::Handler
  def call
    user = User.create_or_update_from_event("public_id" => data["user_id"])
    Notification.create!(subject: "Вам посчитана зарплата за период #{data["name"]}: #{data["amount"]}", user: user)
  end
end
