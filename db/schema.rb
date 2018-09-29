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

ActiveRecord::Schema.define(version: 20180929001457) do

  create_table "applies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "joboffer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["joboffer_id"], name: "index_applies_on_joboffer_id"
    t.index ["user_id"], name: "index_applies_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "receiver"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "updated_at"], name: "index_conversations_on_user_id_and_updated_at"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "friend_requests", force: :cascade do |t|
    t.integer "request_sender"
    t.integer "request_receiver"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["request_receiver"], name: "index_friend_requests_on_request_receiver"
    t.index ["request_sender", "request_receiver"], name: "index_friend_requests_on_request_sender_and_request_receiver", unique: true
    t.index ["request_sender"], name: "index_friend_requests_on_request_sender"
  end

  create_table "joboffers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_joboffers_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_joboffers_on_user_id"
  end

  create_table "joboffers_tskills", force: :cascade do |t|
    t.integer "tskill_id"
    t.integer "joboffer_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.string "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_attachment"
    t.string "audio_attachment"
    t.index ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "tskills", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tskills_joboffers", force: :cascade do |t|
    t.integer "tskill_id"
    t.integer "joboffer_id"
  end

  create_table "tskills_users", force: :cascade do |t|
    t.integer "tskill_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.text "curwork"
    t.text "prevwork"
    t.text "education"
    t.text "skills"
    t.string "profilepic"
    t.boolean "curwork_ispublic", default: true
    t.boolean "prevwork_ispublic", default: true
    t.boolean "education_ispublic", default: true
    t.boolean "skills_ispublic", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
