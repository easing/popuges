class CloseBillingCycle < ApplicationInteraction
  record :user

  run_in_transaction!

  def execute
    billing_cycle = user.current_billing_cycle

    profit = billing_cycle.transactions.sum(Arel.sql "debit - credit")
    billing_cycle.update!(current: false)

    return if profit <= 0

    stream BillingCycleClosed, {
      user_id: billing_cycle.user.public_id,
      name: billing_cycle.name,
      amount: profit
    }
  end
end