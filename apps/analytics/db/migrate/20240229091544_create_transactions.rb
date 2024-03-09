class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :description, null: false, default: ""
      t.references :user, null: false

      t.integer :debit, null: false, default: 0
      t.integer :credit, null: false, default: 0

      t.string :public_id, null: false

      t.timestamps
    end

    add_index :transactions, :public_id, unique: true
  end
end
