class CreateEventsOutbox < ActiveRecord::Migration[7.1]
  def change
    create_table :eda_outbox do |t|
      t.string :topic, null: false
      t.uuid :event_id, null: false
      t.string :event_name, null: false
      t.timestamp :event_time, null: false
      t.integer :event_version, null: false
      t.string :producer, null: false
      t.jsonb :data, null: false, default: {}
    end

    add_index :eda_outbox, :event_id, unique: true
  end
end
