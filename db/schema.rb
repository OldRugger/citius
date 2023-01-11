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

ActiveRecord::Schema[7.0].define(version: 2023_01_08_235544) do
  create_table "configs", force: :cascade do |t|
    t.boolean "active_config"
    t.string "title"
    t.string "hotfolder"
    t.integer "max_time"
    t.integer "day"
    t.boolean "load_teams"
    t.string "csv_delimiter"
    t.string "unique_id"
    t.string "firstname"
    t.string "lastname"
    t.string "entry_class"
    t.string "gender"
    t.string "classifier"
    t.string "time"
    t.string "school"
    t.string "team"
    t.string "jrotc"
    t.string "other_class"
    t.string "other_class_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "host_club"
  end

  create_table "day1_awts", force: :cascade do |t|
    t.string "entryclass"
    t.float "runner1_float_time"
    t.time "runner1_time"
    t.integer "runner1_id"
    t.float "runner2_float_time"
    t.time "runner2_time"
    t.integer "runner2_id"
    t.float "runner3_float_time"
    t.time "runner3_time"
    t.integer "runner3_id"
    t.float "awt_float_time"
    t.time "awt_time"
    t.float "cat_float_time"
    t.time "cat_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "day2_awts", force: :cascade do |t|
    t.string "entryclass"
    t.float "runner1_float_time"
    t.time "runner1_time"
    t.integer "runner1_id"
    t.float "runner2_float_time"
    t.time "runner2_time"
    t.integer "runner2_id"
    t.float "runner3_float_time"
    t.time "runner3_time"
    t.integer "runner3_id"
    t.float "awt_float_time"
    t.time "awt_time"
    t.float "cat_float_time"
    t.time "cat_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runners", force: :cascade do |t|
    t.integer "database_id"
    t.string "surname"
    t.string "firstname"
    t.string "gender"
    t.string "school"
    t.string "entryclass"
    t.time "time1"
    t.float "float_time1"
    t.string "classifier1"
    t.time "time2"
    t.float "float_time2"
    t.string "classifier2"
    t.time "total_time"
    t.float "float_total_time"
    t.float "day1_score"
    t.float "day2_score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "jrotc"
    t.boolean "is_individual_eligible"
    t.index ["database_id"], name: "index_runners_on_database_id", unique: true
  end

  create_table "team_members", force: :cascade do |t|
    t.integer "team_id"
    t.integer "runner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["runner_id"], name: "index_team_members_on_runner_id"
    t.index ["team_id"], name: "index_team_members_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "entryclass"
    t.string "JROTC_branch"
    t.float "day1_score"
    t.float "day2_score"
    t.float "total_score"
    t.float "sort_score"
    t.string "school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_team_eligible"
    t.boolean "club"
  end

end
