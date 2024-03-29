# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_15_070430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "billing_cycles", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "user_id", null: false
    t.boolean "current", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_billing_cycles_on_user_id"
  end

  create_table "eda_outbox", force: :cascade do |t|
    t.string "topic", null: false
    t.uuid "event_id", null: false
    t.string "event_name", null: false
    t.datetime "event_time", precision: nil, null: false
    t.integer "event_version", null: false
    t.string "producer", null: false
    t.jsonb "data", default: {}, null: false
    t.index ["event_id"], name: "index_eda_outbox_on_event_id", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string "subject", null: false
    t.bigint "assignee_id"
    t.datetime "completed_at"
    t.integer "assign_price"
    t.integer "complete_price"
    t.string "public_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jira_id"
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["public_id"], name: "index_tasks_on_public_id", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "billing_cycle_id", null: false
    t.string "transaction_type", null: false
    t.string "description", default: "", null: false
    t.integer "debit", default: 0, null: false
    t.integer "credit", default: 0, null: false
    t.string "public_id", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billing_cycle_id"], name: "index_transactions_on_billing_cycle_id"
    t.index ["public_id"], name: "index_transactions_on_public_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "role"
    t.string "public_id", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["public_id"], name: "index_users_on_public_id", unique: true
  end

  add_foreign_key "tasks", "users", column: "assignee_id"
end
