class User::UpdateBalance < ApplicationInteraction
  record :user

  integer :credit, default: 0
  integer :debit, default: 0

  string :description

  run_in_transaction!

  def execute
    transaction = nil

    Transaction.transaction do
      billing_cycle = user.current_billing_cycle || BillingCycle.create!(user: user, name: Time.zone.today.to_s, current: true)

      transaction = Transaction.create(
        billing_cycle: billing_cycle,
        description: description,
        debit: debit,
        credit: credit
      )
    end

    return if transaction.nil?

    EDA.stream User::BalanceChanged.new(transaction.as_event_data)
  end
end