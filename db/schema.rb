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

ActiveRecord::Schema.define(version: 20160201223626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_ingredients", force: :cascade do |t|
    t.integer "category_id"
    t.integer "ingredient_id"
  end

  add_index "categories_ingredients", ["category_id"], name: "index_categories_ingredients_on_category_id", using: :btree
  add_index "categories_ingredients", ["ingredient_id"], name: "index_categories_ingredients_on_ingredient_id", using: :btree

  create_table "combinations", id: false, force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "complement_id"
  end

  add_index "combinations", ["complement_id", "ingredient_id"], name: "index_combinations_on_complement_id_and_ingredient_id", unique: true, using: :btree
  add_index "combinations", ["ingredient_id", "complement_id"], name: "index_combinations_on_ingredient_id_and_complement_id", unique: true, using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
