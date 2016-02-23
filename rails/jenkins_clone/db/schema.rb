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

ActiveRecord::Schema.define(version: 20160223225004) do

  create_table "command_templates", force: :cascade do |t|
    t.string   "name"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "containers", force: :cascade do |t|
    t.string   "name"
    t.integer  "workers_count"
    t.boolean  "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "docler_containers", force: :cascade do |t|
    t.string   "name"
    t.text     "log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "executable_jobs", force: :cascade do |t|
    t.integer  "container_id",    null: false
    t.integer  "template_job_id", null: false
    t.string   "name"
    t.text     "script"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "queued_jobs", force: :cascade do |t|
    t.integer  "container_id",    null: false
    t.integer  "template_job_id", null: false
    t.string   "name"
    t.text     "script"
    t.text     "log"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "template_jobs", force: :cascade do |t|
    t.string   "name"
    t.text     "script"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
