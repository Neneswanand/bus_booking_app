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

ActiveRecord::Schema[8.1].define(version: 2026_07_21_110934) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "bus_id", null: false
    t.datetime "created_at", null: false
    t.integer "seats"
    t.decimal "total_price"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["bus_id"], name: "index_bookings_on_bus_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "buses", force: :cascade do |t|
    t.string "amenities", default: [], array: true
    t.integer "available_seats"
    t.string "bus_name"
    t.string "bus_number"
    t.string "bus_type"
    t.datetime "created_at", null: false
    t.string "departure_time"
    t.decimal "price"
    t.string "registration_number"
    t.bigint "route_id", null: false
    t.integer "total_seats"
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_buses_on_route_id"
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "destination"
    t.integer "distance"
    t.string "source"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "gender"
    t.string "name"
    t.string "password_digest", null: false
    t.string "phone"
    t.integer "role"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "buses"
  add_foreign_key "bookings", "users"
  add_foreign_key "buses", "routes"
end
