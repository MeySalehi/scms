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

ActiveRecord::Schema.define(version: 20150726060320) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "post_id",      null: false
    t.integer  "user_id"
    t.string   "author"
    t.string   "author_email"
    t.string   "author_url"
    t.text     "content"
    t.string   "meta_keyword"
    t.string   "approved"
    t.integer  "parent_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "options", force: :cascade do |t|
    t.string   "namespace",  null: false
    t.string   "names",      null: false
    t.string   "value"
    t.string   "default"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",           null: false
    t.string   "status",          null: false
    t.string   "comment_status"
    t.datetime "publish_at"
    t.string   "password_digest"
    t.integer  "commnet_count"
    t.text     "content"
    t.string   "meta_keywords"
    t.string   "permalink"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "posts_categories", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "category_id"
  end

  add_index "posts_categories", ["post_id", "category_id"], name: "index_posts_categories_on_post_id_and_category_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",                            null: false
    t.string   "password_digest",                     null: false
    t.string   "full_name"
    t.string   "bio"
    t.string   "avatar"
    t.string   "reset_password_token"
    t.datetime "reset_password_send_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "access_level"
    t.string   "email",                  default: "", null: false
  end

end
