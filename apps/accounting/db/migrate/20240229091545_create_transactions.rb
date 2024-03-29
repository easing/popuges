class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :billing_cycle, null: false

      t.string :transaction_type, null: false
      t.string :description, null: false, default: ""

      t.integer :debit, null: false, default: 0
      t.integer :credit, null: false, default: 0

      t.string :public_id, null: false, default: -> { "gen_random_uuid()" }

      t.timestamps
    end

    add_index :transactions, :public_id, unique: true
  end
end
