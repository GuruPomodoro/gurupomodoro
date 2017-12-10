# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171210105335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interruptions", force: :cascade do |t|
    t.text "reason"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_interruptions_on_user_id"
  end

  create_table "pomodoros", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.bigint "interruption_id"
    t.integer "duration"
    t.boolean "is_break"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trello_task_id"
    t.index ["interruption_id"], name: "index_pomodoros_on_interruption_id"
    t.index ["team_id"], name: "index_pomodoros_on_team_id"
    t.index ["trello_task_id"], name: "index_pomodoros_on_trello_task_id"
    t.index ["user_id"], name: "index_pomodoros_on_user_id"
  end

  create_table "team_invitations", force: :cascade do |t|
    t.bigint "from_id"
    t.bigint "team_id"
    t.string "to_email"
    t.string "to_name"
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["from_id"], name: "index_team_invitations_on_from_id"
    t.index ["team_id"], name: "index_team_invitations_on_team_id"
  end

  create_table "team_users", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "user_id"
    t.string "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trello_board_id"
  end

  create_table "trello_lists", force: :cascade do |t|
    t.string "title"
    t.string "trello_id"
    t.string "trello_board_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.index ["active"], name: "index_trello_lists_on_active"
    t.index ["team_id"], name: "index_trello_lists_on_team_id"
    t.index ["trello_board_id"], name: "index_trello_lists_on_trello_board_id"
    t.index ["trello_id"], name: "index_trello_lists_on_trello_id"
  end

  create_table "trello_tasks", force: :cascade do |t|
    t.string "title"
    t.string "trello_id"
    t.bigint "team_id"
    t.bigint "trello_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.index ["active"], name: "index_trello_tasks_on_active"
    t.index ["team_id"], name: "index_trello_tasks_on_team_id"
    t.index ["trello_id"], name: "index_trello_tasks_on_trello_id"
    t.index ["trello_list_id"], name: "index_trello_tasks_on_trello_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "uid"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trello_token"
    t.string "trello_secret"
    t.jsonb "trello_boards", default: []
    t.string "full_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "interruptions", "users"
  add_foreign_key "pomodoros", "interruptions"
  add_foreign_key "pomodoros", "teams"
  add_foreign_key "pomodoros", "trello_tasks"
  add_foreign_key "pomodoros", "users"
  add_foreign_key "team_invitations", "teams"
  add_foreign_key "team_invitations", "users", column: "from_id"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
  add_foreign_key "trello_lists", "teams"
  add_foreign_key "trello_tasks", "teams"
  add_foreign_key "trello_tasks", "trello_lists"
end
