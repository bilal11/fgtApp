
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

ActiveRecord::Schema.define(:version => 20121223164010) do

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "commenter_name"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.text     "text"
    t.string   "comment_time"
    t.string   "commenter_fb_id"
    t.string   "comment_fb_id"
    t.integer  "total_likes",     :default => 0
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friends", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.string   "facebook_id"
    t.integer  "user_id"
  end

  create_table "likes", :force => true do |t|
    t.string   "liker_name"
    t.integer  "post_id"
    t.integer  "comment_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "liker_fb_id"
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "user_id"
    t.text     "text"
    t.string   "poster_name"
    t.integer  "total_likes",     :default => 0
    t.integer  "total_comments",  :default => 0
    t.string   "post_time"
    t.string   "fb_post_id"
    t.string   "post_name"
    t.string   "type"
    t.string   "status_type"
    t.string   "picture_url"
    t.string   "shared_pic_link"
    t.text     "story"
    t.string   "poster_fb_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "name"
    t.string   "facebook_id"
    t.string   "fb_access_token"
    t.string   "fb_display_picture_url"
  end

end

