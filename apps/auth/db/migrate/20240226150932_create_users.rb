# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :role, null: false, default: User.roles[:guest]
      t.string :public_id, null: false, default: -> { "gen_random_uuid()" }

      t.timestamps
    end

    add_index :users, :public_id, unique: true
  end
end
