class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :subject, default: "", null: false
      t.references :user, foreign_key: true
      t.string :public_id, null: false, default: -> { "gen_random_uuid()" }
      t.timestamps
    end

    add_index :notifications, :public_id, unique: true
  end
end
