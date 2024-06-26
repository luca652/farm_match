# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_06_14_201535) do
  create_table "answers", force: :cascade do |t|
    t.string "label"
    t.integer "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "details", default: {}
    t.integer "kind"
    t.index ["service_id"], name: "index_answers_on_service_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "headline"
    t.string "description"
    t.integer "user_id", null: false
    t.string "category"
    t.string "subcategory"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "job_id", null: false
    t.string "name"
    t.index ["job_id"], name: "index_services_on_job_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "services"
  add_foreign_key "jobs", "users"
  add_foreign_key "services", "jobs"
end
