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

ActiveRecord::Schema.define(:version => 20140622190220) do

  create_table "letters", :force => true do |t|
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.string   "email"
    t.string   "salutation"
    t.string   "nickname"
    t.text     "content"
    t.string   "delivery_method"
    t.datetime "delivery_date"
    t.integer  "views_count",     :default => 0
    t.integer  "hearts_count",    :default => 0
    t.boolean  "read",            :default => false
    t.boolean  "private",         :default => true
    t.boolean  "anonymous",       :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "city"
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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "draft"
  end

end
