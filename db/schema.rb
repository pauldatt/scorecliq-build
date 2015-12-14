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

ActiveRecord::Schema.define(version: 20151209160720) do

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

  create_table "friendships", force: :cascade do |t|
    t.string   "user_id"
    t.string   "friend_id"
    t.boolean  "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id"
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "invitations", force: :cascade do |t|
    t.string   "recipient_name"
    t.string   "recipient_email"
    t.integer  "scoreboard_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "invitations", ["scoreboard_id"], name: "index_invitations_on_scoreboard_id"

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type"

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"

  create_table "pictures", force: :cascade do |t|
    t.string   "picture"
    t.integer  "pictureable_id"
    t.string   "pictureable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "pictures", ["pictureable_id", "pictureable_type"], name: "index_pictures_on_pictureable_id_and_pictureable_type"

  create_table "schedules", force: :cascade do |t|
    t.string   "team1"
    t.string   "team2"
    t.text     "detail"
    t.integer  "scoreboard_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "schedules", ["scoreboard_id"], name: "index_schedules_on_scoreboard_id"

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
