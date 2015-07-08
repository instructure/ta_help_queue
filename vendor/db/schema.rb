# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150707145958) do

  create_table "admins", force: :cascade do |t|
    t.integer  "admin_id"
    t.string   "password"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "authorized"
  end

  create_table "past_requests", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "removed_by"
    t.float    "time_waited"
    t.boolean  "received_help"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "past_requests", ["removed_by"], name: "index_past_requests_on_removed_by"
  add_index "past_requests", ["student_id"], name: "index_past_requests_on_student_id"

  create_table "requests", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "requests", ["student_id"], name: "index_requests_on_student_id"

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.integer  "id_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "password"
  end

end
