class Transaction::CreatedConsumer < EDA::Consumer
  version 1 do
    Transaction.create_or_update_from_event(event.data)
  end
end