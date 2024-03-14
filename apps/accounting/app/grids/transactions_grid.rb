class TransactionsGrid < ApplicationGrid
  scope { Transaction }

  column :id
  column :credit
  column :debit
  column :user do |record|
    record.user.display_name
  end
  column :transaction_type, html: true do |resource|
    content_tag(:code, resource.transaction_type)
  end
  column :description
end