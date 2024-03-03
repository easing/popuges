class UpdateUserBalance < ApplicationInteraction
  record :user
  integer :credit, default: 0
  integer :debit, default: 0
  string :description

  def execute
    transaction = Transaction.create!(inputs)
    stream UserBalanceChanged, transaction
  end
end