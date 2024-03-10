class CreateBillingCycles < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_cycles do |t|
      t.string :name, null: false, default: ""
      t.references :user, null: false
      t.boolean :current, null: false, default: false

      t.timestamps
    end
  end
end
