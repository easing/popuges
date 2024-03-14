# frozen_string_literal: true

#
class User::BalanceChangedConsumer < EDA::Consumer
  version 1 do |event|
    data = event.data
    user = User.find_or_create_by!(public_id: data["user_id"])

    Transaction
      .create_with(user: user, debit: data["debit"], credit: data["credit"], public_id: data["public_id"], description: data["description"])
      .create_or_find_by!(public_id: data["public_id"])
  end
end
