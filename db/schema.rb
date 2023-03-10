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

ActiveRecord::Schema.define(version: 2023_01_05_164321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "strava_uid"
    t.string "strava_id"
    t.datetime "date"
    t.string "title"
    t.float "distance"
    t.float "calories_burned"
    t.float "gas_money_saved"
    t.float "beers_banked"
    t.string "latitude"
    t.string "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "strava_uid"
    t.float "brubank", default: 0.0
    t.float "beers_drunk", default: 0.0
    t.float "beers_earned", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "users"
end
