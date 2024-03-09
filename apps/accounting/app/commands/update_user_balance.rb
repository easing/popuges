class UpdateUserBalance < ApplicationInteraction
  record :user
  integer :credit, default: 0
  integer :debit, default: 0
  string :description

  def execute
    transaction = Transaction.create!(inputs)

    stream UserBalanceChanged, {
      public_id: transaction.public_id,
      user_id: transaction.user.public_id,
      credit: transaction.credit,
      debit: transaction.debit
    }
  end
end