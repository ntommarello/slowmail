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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140713212941) do

  create_table "conversations", :force => true do |t|
    t.integer  "sidebar_owner_id"
    t.string   "cc_user_ids"
    t.integer  "last_letter_id"
    t.integer  "message_count",    :default => 1
    t.boolean  "unread",           :default => true
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.string   "tagline"
    t.string   "avatar"
    t.text     "description"
    t.boolean  "privacy_invite_only",       :default => false
    t.boolean  "privacy_members_only_view", :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "letters", :force => true do |t|
    t.integer  "author_id"
    t.string   "salutation"
    t.string   "nickname"
    t.text     "content"
    t.string   "delivery_method"
    t.datetime "delivery_date"
    t.integer  "views_count",     :default => 0
    t.integer  "hearts_count",    :default => 0
    t.boolean  "private",         :default => true
    t.boolean  "anonymous",       :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "city"
    t.text     "subject"
    t.integer  "to_count",        :default => 1
    t.string   "tag"
    t.string   "participant_ids"
    t.boolean  "delivered"
    t.boolean  "mailed",          :default => false
    t.datetime "mailed_at"
  end

  create_table "subscribed_groups", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.boolean  "moderator",  :default => false
    t.boolean  "owner",      :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "unread",     :default => true
    t.boolean  "replied",    :default => false
  end

  create_table "subscribed_letters", :force => true do |t|
    t.integer  "letter_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "read",       :default => false
    t.integer  "group_id"
    t.string   "email"
    t.datetime "read_on"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "login_count"
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "oath_token"
    t.datetime "oath_expires_at"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.text     "draft"
    t.string   "auto_login_token"
    t.string   "username"
    t.boolean  "admin",            :default => false
  end

end
