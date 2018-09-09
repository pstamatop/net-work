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

ActiveRecord::Schema.define(version: 20180909121029) do

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
