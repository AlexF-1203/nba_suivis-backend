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

ActiveRecord::Schema[7.1].define(version: 2025_01_21_113803) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "device_tokens", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "token"
    t.string "platform"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_device_tokens_on_user_id"
  end

  create_table "favorite_players", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_favorite_players_on_player_id"
    t.index ["user_id"], name: "index_favorite_players_on_user_id"
  end

  create_table "favorite_teams", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_favorite_teams_on_team_id"
    t.index ["user_id"], name: "index_favorite_teams_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "team_1_id", null: false
    t.integer "team_2_id", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_1_score"
    t.integer "team_2_score"
    t.integer "team_1_q1"
    t.integer "team_1_q2"
    t.integer "team_1_q3"
    t.integer "team_1_q4"
    t.integer "team_2_q1"
    t.integer "team_2_q2"
    t.integer "team_2_q3"
    t.integer "team_2_q4"
    t.string "status"
    t.integer "game_api_id"
    t.index ["game_api_id"], name: "index_games_on_game_api_id"
    t.index ["team_1_id"], name: "index_games_on_team_1_id"
    t.index ["team_2_id"], name: "index_games_on_team_2_id"
  end

  create_table "player_games", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "game_id", null: false
    t.integer "team_id", null: false
    t.integer "points"
    t.integer "rebounds"
    t.integer "assists"
    t.integer "minutes"
    t.integer "blocks"
    t.integer "steals"
    t.decimal "free_throw_percentage"
    t.decimal "true_shooting_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "three_point_percentage"
    t.integer "personal_fouls"
    t.integer "turnovers"
    t.integer "offensive_rebounds"
    t.integer "defensive_rebounds"
    t.index ["game_id"], name: "index_player_games_on_game_id"
    t.index ["player_id", "game_id"], name: "index_player_games_on_player_id_and_game_id", unique: true
    t.index ["player_id"], name: "index_player_games_on_player_id"
    t.index ["team_id"], name: "index_player_games_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "profile"
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "conference"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "logo_url"
    t.integer "wins"
    t.integer "losses"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "username"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "device_tokens", "users"
  add_foreign_key "favorite_players", "players"
  add_foreign_key "favorite_players", "users"
  add_foreign_key "favorite_teams", "teams"
  add_foreign_key "favorite_teams", "users"
  add_foreign_key "games", "teams", column: "team_1_id"
  add_foreign_key "games", "teams", column: "team_2_id"
  add_foreign_key "player_games", "games"
  add_foreign_key "player_games", "players"
  add_foreign_key "player_games", "teams"
  add_foreign_key "players", "teams"
end
