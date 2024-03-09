# frozen_string_literal: true

class User < ::ApplicationRecord
  include UserConcern

  has_many :transactions
  has_many :tasks, inverse_of: :assignee

  def balance
    transactions.sum(Arel.sql "debit - credit")
  end
end
