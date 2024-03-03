class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :user, type: :uuid, null: false
      t.string :description, null: false, default: ""
      t.integer :debit, null: false, default: 0
      t.integer :credit, null: false, default: 0
      t.timestamps
    end
  end
end
