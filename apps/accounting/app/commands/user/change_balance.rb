class User::ChangeBalance < ApplicationInteraction
  record :user

  integer :credit, default: 0
  integer :debit, default: 0

  string :description
  string :transaction_type

  run_in_transaction!

  def execute
    transaction = nil

    Transaction.transaction do
      billing_cycle = user.current_billing_cycle || BillingCycle.create!(user: user, name: Time.zone.today.to_s, current: true)

      transaction = Transaction.create!(
        billing_cycle: billing_cycle,
        transaction_type: transaction_type,
        description: description,
        debit: debit,
        credit: credit
      )
    end

    return if transaction.nil?

    EDA.stream User::BalanceChanged.new(transaction.as_event_data)
  end
end