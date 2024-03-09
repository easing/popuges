class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :subject, null: false
      t.references :assignee, foreign_key: { to_table: :users }
      t.datetime :completed_at

      t.integer :assign_price
      t.integer :complete_price

      t.string :public_id, null: false

      t.timestamps
    end

    add_index :tasks, :public_id, unique: true
  end
end
