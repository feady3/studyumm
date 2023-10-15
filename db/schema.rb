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

ActiveRecord::Schema[7.0].define(version: 2023_10_15_083523) do
  create_table "friendslogs", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grouplogs", force: :cascade do |t|
    t.text "user_uniqid"
    t.text "group_uniqid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "tip"
  end

  create_table "groups", force: :cascade do |t|
    t.text "uniqid"
    t.text "name"
    t.text "in_which"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "icon"
    t.string "manager"
  end

  create_table "posts", force: :cascade do |t|
    t.string "user_uniqid"
    t.string "exam_name"
    t.text "comments"
    t.string "publish_range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "only_friends"
    t.integer "math1"
    t.integer "math2"
    t.integer "en1"
    t.integer "en2"
    t.integer "ja1"
    t.integer "ja2"
    t.integer "sci1"
    t.integer "sci2"
    t.integer "soc1"
    t.integer "soc2"
    t.integer "total"
  end

  create_table "users", force: :cascade do |t|
    t.text "uniqid"
    t.text "email"
    t.text "user_id"
    t.text "user_name"
    t.text "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "icon"
  end

end
