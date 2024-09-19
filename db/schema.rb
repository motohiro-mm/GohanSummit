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

ActiveRecord::Schema[7.2].define(version: 2024_09_19_033325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "families", force: :cascade do |t|
    t.string "invitation_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_plans", force: :cascade do |t|
    t.date "meal_date", null: false
    t.bigint "family_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id", "meal_date"], name: "index_meal_plans_on_family_id_and_meal_date", unique: true
    t.index ["family_id"], name: "index_meal_plans_on_family_id"
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "meal_plan_id", null: false
    t.string "name", null: false
    t.integer "timing", null: false
    t.text "memo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_id", "timing"], name: "index_meals_on_meal_plan_id_and_timing", unique: true
    t.index ["meal_plan_id"], name: "index_meals_on_meal_plan_id"
    t.check_constraint "timing = ANY (ARRAY[0, 1, 2])", name: "timing_check"
  end

  create_table "meeting_rooms", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.bigint "meal_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id", "meal_plan_id"], name: "index_meeting_rooms_on_family_id_and_meal_plan_id", unique: true
    t.index ["family_id"], name: "index_meeting_rooms_on_family_id"
    t.index ["meal_plan_id"], name: "index_meeting_rooms_on_meal_plan_id"
  end

  create_table "remarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meeting_room_id", null: false
    t.integer "remark_type", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_room_id"], name: "index_remarks_on_meeting_room_id"
    t.index ["user_id"], name: "index_remarks_on_user_id"
    t.check_constraint "remark_type = ANY (ARRAY[0, 1])", name: "remark_type_check"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "family_id", null: false
    t.string "name", limit: 20, null: false
    t.string "uid", null: false
    t.string "provider", null: false
    t.integer "icon", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_users_on_family_id"
  end

  add_foreign_key "meal_plans", "families"
  add_foreign_key "meals", "meal_plans"
  add_foreign_key "meeting_rooms", "families"
  add_foreign_key "meeting_rooms", "meal_plans"
  add_foreign_key "remarks", "meeting_rooms"
  add_foreign_key "remarks", "users"
  add_foreign_key "users", "families"
end
