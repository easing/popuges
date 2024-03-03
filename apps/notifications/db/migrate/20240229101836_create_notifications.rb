class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications, id: :uuid do |t|
      t.string :subject, default: "", null: false
      t.references :user, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
