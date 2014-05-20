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

ActiveRecord::Schema.define(version: 20140520005632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "benefits", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "citations", force: true do |t|
    t.string  "source"
    t.integer "flags",        default: 0
    t.integer "citable_id"
    t.integer "citer_id"
    t.string  "citable_type"
    t.string  "citer_type"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
  end

  create_table "images", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredient_nutrients", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "nutrient_id"
    t.string   "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "daily_value"
    t.string   "unit"
  end

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "serving_size"
    t.string   "source_url"
    t.string   "usda_name"
  end

  create_table "measurements", force: true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.decimal  "amount"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutrients", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "symbol"
    t.string   "nutrient_type"
    t.string   "usda_name"
  end

  create_table "posts", force: true do |t|
    t.text     "body"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "abstract"
    t.integer  "user_id"
    t.text     "headline"
    t.boolean  "core_content", default: false
  end

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.decimal  "rating",     precision: 1, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "instructions"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "rating",             precision: 1, scale: 0
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "usda_food_groups", id: false, force: true do |t|
    t.string "code",        null: false
    t.string "description", null: false
  end

  create_table "usda_foods", id: false, force: true do |t|
    t.string  "nutrient_databank_number", null: false
    t.string  "food_group_code"
    t.string  "long_description",         null: false
    t.string  "short_description",        null: false
    t.string  "common_names"
    t.string  "manufacturer_name"
    t.boolean "survey"
    t.string  "refuse_description"
    t.integer "percentage_refuse"
    t.float   "nitrogen_factor"
    t.float   "protein_factor"
    t.float   "fat_factor"
    t.float   "carbohydrate_factor"
  end

  create_table "usda_foods_nutrients", force: true do |t|
    t.string  "nutrient_databank_number",     null: false
    t.string  "nutrient_number",              null: false
    t.float   "nutrient_value",               null: false
    t.integer "num_data_points",              null: false
    t.float   "standard_error"
    t.string  "src_code",                     null: false
    t.string  "derivation_code"
    t.string  "ref_nutrient_databank_number"
    t.boolean "add_nutrient_mark"
    t.integer "num_studies"
    t.float   "min"
    t.float   "max"
    t.integer "degrees_of_freedom"
    t.float   "lower_error_bound"
    t.float   "upper_error_bound"
    t.string  "statistical_comments"
    t.string  "add_mod_date"
    t.string  "confidence_code"
  end

  add_index "usda_foods_nutrients", ["nutrient_databank_number", "nutrient_number"], name: "foods_nutrients_index", using: :btree

  create_table "usda_footnotes", force: true do |t|
    t.string "nutrient_databank_number", null: false
    t.string "footnote_number",          null: false
    t.string "footnote_type",            null: false
    t.string "nutrient_number"
    t.string "footnote_text",            null: false
  end

  create_table "usda_nutrients", id: false, force: true do |t|
    t.string  "nutrient_number",       null: false
    t.string  "units",                 null: false
    t.string  "tagname"
    t.string  "nutrient_description",  null: false
    t.string  "number_decimal_places", null: false
    t.integer "sort_record_order",     null: false
  end

  create_table "usda_source_codes", force: true do |t|
    t.string "code",        null: false
    t.string "description", null: false
  end

  create_table "usda_weights", force: true do |t|
    t.string  "nutrient_databank_number", null: false
    t.string  "sequence_number",          null: false
    t.float   "amount",                   null: false
    t.string  "measurement_description",  null: false
    t.float   "gram_weight",              null: false
    t.integer "num_data_points"
    t.float   "standard_deviation"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "name"
    t.string   "username"
    t.boolean  "email_list",             default: true
    t.boolean  "terms_of_service",       default: false
    t.string   "mailchimp_member_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
