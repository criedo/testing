# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "categories", :force => true do |t|
    t.datetime  "created_at",                                  :null => false
    t.timestamp "update_at",                                   :null => false
    t.integer   "active",       :limit => 1,   :default => 1,  :null => false
    t.integer   "rank",         :limit => 4,   :default => 0,  :null => false
    t.string    "title",        :limit => 128, :default => "", :null => false
    t.text      "instructions"
  end

  add_index "categories", ["title"], :name => "categories_title", :unique => true
  add_index "categories", ["rank", "title"], :name => "categories_rank_title"

  create_table "recipes", :force => true do |t|
    t.string   "title"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes_old", :force => true do |t|
    t.datetime  "created_at",                                   :null => false
    t.timestamp "update_at",                                    :null => false
    t.integer   "active",        :limit => 1,   :default => 1,  :null => false
    t.integer   "rank",          :limit => 4,   :default => 0,  :null => false
    t.integer   "categories_id", :limit => 10,  :default => 1,  :null => false
    t.string    "title",         :limit => 128, :default => "", :null => false
    t.text      "instructions"
  end

  add_index "recipes_old", ["title"], :name => "recipes_title", :unique => true
  add_index "recipes_old", ["rank", "title"], :name => "recipes_rank_title"
  add_index "recipes_old", ["categories_id", "rank", "title"], :name => "recipes_categ_rank_title"

end
