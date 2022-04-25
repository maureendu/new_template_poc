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

ActiveRecord::Schema[7.0].define(version: 2022_03_10_232913) do
  create_table "employers", charset: "latin1", force: :cascade do |t|
    t.integer "tmp_employer_id", null: false
    t.string "client_slug", limit: 50, null: false
    t.boolean "enabled", null: false
  end

  create_table "projects", charset: "latin1", force: :cascade do |t|
    t.string "bill_method", null: false
    t.integer "budgeted_hours"
    t.string "close_reason"
    t.datetime "deleted_at"
    t.text "description", null: false
    t.string "external_id", limit: 50, null: false
    t.boolean "full_time", null: false
    t.json "locations"
    t.integer "markup"
    t.integer "number_of_roles", null: false
    t.string "preferred_experience_level"
    t.boolean "project_based", null: false
    t.float "rate"
    t.boolean "remote_ok", null: false
    t.integer "remote_percentage"
    t.json "request_payload", null: false
    t.datetime "start_date", null: false
    t.string "title", null: false
    t.boolean "travel_required"
    t.bigint "employer_id", null: false
    t.index ["employer_id"], name: "index_projects_on_employer_id"
    t.index ["external_id", "employer_id"], name: "index_projects_on_external_id_and_employer_id", unique: true
  end

  add_foreign_key "projects", "employers"
end
