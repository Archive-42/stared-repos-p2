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

ActiveRecord::Schema.define(version: 20190417183859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cats", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corgis", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toys", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "toyable_id"
    t.string "toyable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "toyable_id", "toyable_type"], name: "index_toys_on_name_and_toyable_id_and_toyable_type", unique: true
    t.index ["name"], name: "index_toys_on_name", unique: true
    t.index ["toyable_id"], name: "index_toys_on_toyable_id"
    t.index ["toyable_type", "toyable_id"], name: "index_toys_on_toyable_type_and_toyable_id"
  end

end
