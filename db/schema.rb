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

ActiveRecord::Schema.define(:version => 20111015211513) do

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 1
    t.integer  "assigner"
    t.datetime "when"
    t.string   "status",     :limit => 1, :default => "N"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.decimal  "longtitude",                :precision => 10, :scale => 8, :default => 0.0
    t.decimal  "lattitude",                 :precision => 10, :scale => 8, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", :limit => 25
    t.integer  "user"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tasks", :force => true do |t|
    t.integer  "user_id"
    t.string   "ttype",                          :limit => 1,                                :default => "P"
    t.integer  "subtype",                        :limit => 2
    t.string   "priority",                       :limit => 1,                                :default => "L"
    t.datetime "due"
    t.datetime "notification"
    t.boolean  "repititive",                                                                 :default => false
    t.datetime "finish_on"
    t.string   "status",                         :limit => 1,                                :default => "O"
    t.datetime "status_date"
    t.integer  "assigner"
    t.boolean  "email_notification_to_assignee"
    t.boolean  "sms_notification_to_assignee"
    t.boolean  "email_notification_to_assigner"
    t.boolean  "sms_notification_to_assigner"
    t.string   "accessible_by",                  :limit => 1,                                :default => "N"
    t.decimal  "budget",                                       :precision => 9, :scale => 2, :default => 0.0
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",                    :limit => 30
    t.text     "long_description"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                   :limit => 23
    t.string   "email",                  :limit => 45
    t.string   "encrypted_password",     :limit => 64
    t.string   "salt",                   :limit => 64
    t.boolean  "status",                               :default => false
    t.boolean  "family_view_access",                   :default => false
    t.boolean  "family_assign_tasks",                  :default => false
    t.boolean  "friends_view_access",                  :default => false
    t.boolean  "friends_assign_access",                :default => false
    t.boolean  "employer_view_access",                 :default => false
    t.boolean  "employer_assign_access",               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "failedlogin",            :limit => 1,  :default => 0
    t.string   "cryptopass",             :limit => 4
    t.datetime "time_forgot_password"
    t.string   "selected_language",      :limit => 2,  :default => "el"
  end

  add_index "users", ["cryptopass"], :name => "index_users_on_cryptopass", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
