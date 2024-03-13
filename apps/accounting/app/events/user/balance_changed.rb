# frozen_string_literal: true

##
class User::BalanceChanged < EDA::Event
  topic :balance_changes
end