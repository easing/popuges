class UpdateUserBalance < ApplicationInteraction
  record :user

  integer :credit, default: 0
  integer :debit, default: 0

  string :description

  run_in_transaction!

  def execute
    billing_cycle = user.current_billing_cycle || BillingCycle.create!(user: user, name: Time.zone.today.to_s, current: true)

    transaction = Transaction.create!(
      billing_cycle: billing_cycle,
      description: description,
      debit: debit,
      credit: credit
    )

    stream UserBalanceChanged, {
      public_id: transaction.public_id,
      user_id: transaction.billing_cycle.user.public_id,
      credit: transaction.credit,
      debit: transaction.debit
    }
  end
end