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

ActiveRecord::Schema.define(version: 20151015143455) do

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "scoreboard_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry"
  add_index "comments", ["scoreboard_id"], name: "index_comments_on_scoreboard_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "favourites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "scoreboard_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "favourites", ["scoreboard_id"], name: "index_favourites_on_scoreboard_id"
  add_index "favourites", ["user_id", "scoreboard_id"], name: "index_favourites_on_user_id_and_scoreboard_id", unique: true
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id"

  create_table "scoreboards", force: :cascade do |t|
    t.string   "name_of_scoreboard"
    t.string   "name_of_organization"
    t.string   "name_of_activity"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "starts_at"
    t.date     "ends_at"
    t.string   "states"
    t.string   "country"
    t.string   "cities"
    t.string   "picture"
    t.string   "status"
  end

  add_index "scoreboards", ["user_id", "created_at"], name: "index_scoreboards_on_user_id_and_created_at"
  add_index "scoreboards", ["user_id"], name: "index_scoreboards_on_user_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "win"
    t.integer  "loss"
    t.integer  "tie"
    t.integer  "scoreboard_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "teams", ["scoreboard_id"], name: "index_teams_on_scoreboard_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
