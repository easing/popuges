class CalculateWage < ApplicationInteraction
  record :user

  def execute


    stream UserBalanceChanged, {
      public_id: transaction.public_id,
      user_id: transaction.user.public_id,
      credit: transaction.credit,
      debit: transaction.debit
    }
  end
end