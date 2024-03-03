class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :subject, null: false
      t.references :assigned_to, foreign_key: { to_table: :users }, type: :uuid
      t.datetime :completed_at

      t.integer :assign_price
      t.integer :complete_price

      t.timestamps
    end
  end
end
