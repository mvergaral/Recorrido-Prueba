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

ActiveRecord::Schema[7.0].define(version: 2022_11_18_030033) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.jsonb "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies_engineers", force: :cascade do |t|
    t.bigint "engineer_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_engineers_on_company_id"
    t.index ["engineer_id"], name: "index_companies_engineers_on_engineer_id"
  end

  create_table "engineers", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turn_availabilities", force: :cascade do |t|
    t.datetime "date"
    t.bigint "engineer_id", null: false
    t.bigint "company_id", null: false
    t.bigint "turn_id", null: false
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_turn_availabilities_on_company_id"
    t.index ["engineer_id"], name: "index_turn_availabilities_on_engineer_id"
    t.index ["turn_id"], name: "index_turn_availabilities_on_turn_id"
  end

  create_table "turns", force: :cascade do |t|
    t.datetime "date"
    t.bigint "engineer_id"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_turns_on_company_id"
    t.index ["engineer_id"], name: "index_turns_on_engineer_id"
  end

  add_foreign_key "companies_engineers", "companies"
  add_foreign_key "companies_engineers", "engineers"
  add_foreign_key "turn_availabilities", "companies"
  add_foreign_key "turn_availabilities", "engineers"
  add_foreign_key "turn_availabilities", "turns"
  add_foreign_key "turns", "companies"
end
