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

ActiveRecord::Schema.define(:version => 20121215082548) do

  create_table "categories", :force => true do |t|
    t.string   "code",          :limit => 2
    t.string   "ttype",         :limit => 1
    t.string   "enDescription", :limit => 30
    t.string   "elDescription", :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "categories", ["user_id"], :name => "index_categories_on_user_id"

  create_table "expense_journals", :force => true do |t|
    t.string   "trxtype",     :limit => 1
    t.datetime "trxdatetime"
    t.integer  "sn"
    t.decimal  "amount",                   :precision => 9, :scale => 2, :default => 0.0
    t.date     "dateoccured"
    t.string   "category",    :limit => 2
    t.string   "subcategory", :limit => 2,                               :default => "01"
    t.string   "exptype",     :limit => 1
    t.string   "expmethod",   :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "expenses", :force => true do |t|
    t.decimal  "amount",                      :precision => 9, :scale => 2, :default => 0.0
    t.date     "dateoccured"
    t.string   "method",         :limit => 1,                               :default => "M"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mobileid"
    t.string   "sync",           :limit => 1
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "ttype",          :limit => 1
    t.integer  "subcategory_id"
  end

  add_index "expenses", ["mobileid"], :name => "index_expenses_on_webid", :unique => true
  add_index "expenses", ["user_id"], :name => "index_expenses_on_user_id"

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

  create_table "subcategories", :force => true do |t|
    t.string   "Subcategory_code", :limit => 2
    t.string   "ttype",            :limit => 1
    t.string   "enDescription",    :limit => 30
    t.string   "elDescription",    :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "category_id"
  end

  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"

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
