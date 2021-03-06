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

ActiveRecord::Schema.define(version: 20140129141522) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "groups", ["email"], name: "index_groups_on_email", unique: true
  add_index "groups", ["remember_token"], name: "index_groups_on_remember_token"

  create_table "lessons", force: true do |t|
    t.string   "name"
    t.integer  "form"
    t.integer  "number"
    t.string   "classroom"
    t.integer  "day"
    t.integer  "start_week"
    t.integer  "end_week"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "periodicity"
  end

end
