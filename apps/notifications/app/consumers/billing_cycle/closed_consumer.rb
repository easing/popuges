# frozen_string_literal: true

#
class BillingCycle::ClosedConsumer < EDA::Consumer
  def call
    user = User.create_or_update_from_event("public_id" => data["user_id"])
    Notification.create!(subject: "Вам посчитана зарплата за период #{data["name"]}: #{data["amount"]}💸", user: user)
    Notification.create!(subject: "Выплачена зарплата за период #{data["name"]}: #{data["amount"]}💸 попугу #{user.display_name}")
  end
end
