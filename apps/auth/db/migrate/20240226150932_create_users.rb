# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name
      t.string :role, null: false, default: User.roles[:guest]

      t.timestamps
    end
  end
end
