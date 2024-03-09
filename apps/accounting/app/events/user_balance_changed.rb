# frozen_string_literal: true

##
class UserBalanceChanged < Event
  def topic = "balance_changes"
end