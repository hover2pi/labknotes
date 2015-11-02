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

ActiveRecord::Schema.define(:version => 20110823002452) do

  create_table "answers", :force => true do |t|
    t.text     "content"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.boolean  "spreadsheet", :default => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "format",           :default => "markdown"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "semester"
    t.string   "short_name"
    t.integer  "professor_id"
    t.text     "syllabus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "knotebooks", :force => true do |t|
    t.string   "title"
    t.text     "abstract"
    t.integer  "professor_id"
    t.boolean  "favorite",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
    t.datetime "due_at"
    t.integer  "position"
    t.string   "state"
  end

  create_table "knotes", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "professor_id"
    t.integer  "difficulty"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "format",       :default => "markdown"
  end

  create_table "knotings", :force => true do |t|
    t.integer  "knotebook_id"
    t.integer  "knote_id"
    t.integer  "y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "x",            :default => 1
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.text     "explanation"
    t.integer  "position"
    t.integer  "knotebook_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "spreadsheet",  :default => false
  end

  create_table "reports", :force => true do |t|
    t.integer  "student_id"
    t.integer  "knotebook_id"
    t.float    "grade"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "submitted_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "knote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",        :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",        :null => false
    t.string   "password_salt",                       :default => "",        :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask",                          :default => 1
    t.string   "first"
    t.string   "last"
    t.string   "type",                                :default => "Student"
    t.integer  "student_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
