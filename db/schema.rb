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

ActiveRecord::Schema.define(:version => 20140114085254) do

  create_table "authors", :force => true do |t|
    t.integer "author_id"
    t.string  "name"
  end

  create_table "feature_tag_ships", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "features", :force => true do |t|
    t.text     "name"
    t.integer  "sort"
    t.text     "description"
    t.integer  "author"
    t.text     "remark"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "machine_types", :force => true do |t|
    t.integer  "machine_type_id"
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "machines", :force => true do |t|
    t.text     "name"
    t.text     "ip"
    t.text     "credential"
    t.integer  "machine_type"
    t.text     "remark"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "roadrunners", :force => true do |t|
    t.text     "name"
    t.text     "script"
    t.text     "description"
    t.text     "remark"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "snmps", :force => true do |t|
    t.string   "simulated_ip"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "status",       :default => "off"
  end

  create_table "sorts", :force => true do |t|
    t.integer "sort_id"
    t.string  "name"
  end

  create_table "tags", :force => true do |t|
    t.text     "name"
    t.text     "remark"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
