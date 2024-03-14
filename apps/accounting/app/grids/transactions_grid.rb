class TransactionsGrid < ApplicationGrid
  scope { Transaction }

  column :id
  column :credit
  column :debit
  column :user do |record|
    record.user.display_name
  end
  column :description
end