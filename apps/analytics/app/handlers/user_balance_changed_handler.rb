# frozen_string_literal: true

#
class UserBalanceChangedHandler < ::Handler
  def call
    Transaction
      .create_with(
        user: User.create_with(role: "guest").find_or_create_by!(id: data["assigned_to_id"]),
        debit: data["debit"],
        credit: data["credit"]
      )
      .create_or_find_by!(id: data["id"])
  end
end
