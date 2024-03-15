# frozen_string_literal: true

##
class User::BalanceChanged < EDA::Event
  topic :balance_changes
  # transactional! # Передать событие через outbox-таблицу в БД
end