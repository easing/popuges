# frozen_string_literal: true

#
class User::BalanceChangedConsumer < EDA::Consumer
  version 1 do
    Transaction.create_or_update_from_event(event)
  end
end

