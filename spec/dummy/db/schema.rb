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

ActiveRecord::Schema.define(version: 20160509134900) do

  create_table "items", force: :cascade do |t|
    t.string "name"
  end

  add_index "items", ["name"], name: "index_items_on_name"

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

  add_index "users", ["name"], name: "index_users_on_name"

end
