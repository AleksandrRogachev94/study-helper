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

ActiveRecord::Schema.define(version: 20170427135021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "lesson_id"
    t.index ["lesson_id"], name: "comment_lesson_id_ix", using: :btree
    t.index ["user_id"], name: "comment_user_id_ix", using: :btree
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.text     "links"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "doc1_file_name"
    t.string   "doc1_content_type"
    t.integer  "doc1_file_size"
    t.datetime "doc1_updated_at"
    t.string   "doc2_file_name"
    t.string   "doc2_content_type"
    t.integer  "doc2_file_size"
    t.datetime "doc2_updated_at"
    t.string   "doc3_file_name"
    t.string   "doc3_content_type"
    t.integer  "doc3_file_size"
    t.datetime "doc3_updated_at"
    t.index ["category_id"], name: "lesson_category_id_ix", using: :btree
    t.index ["user_id"], name: "lesson_user_id_ix", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.integer  "age"
    t.string   "study_place"
    t.string   "degree"
    t.string   "interests"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["user_id"], name: "profile_user_id_ix", using: :btree
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["student_id"], name: "request_student_id_ix", using: :btree
    t.index ["teacher_id"], name: "request_teacher_id_ix", using: :btree
  end

  create_table "studyships", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "student_id_ix", using: :btree
    t.index ["teacher_id"], name: "teacher_id_ix", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "provider"
    t.string   "uid"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
