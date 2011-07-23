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

ActiveRecord::Schema.define(:version => 20110723044022) do

  create_table "users", :force => true do |t|
    t.string   "name",                   :limit => 23
    t.string   "email",                  :limit => 30
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
