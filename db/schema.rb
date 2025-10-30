ActiveRecord::Schema[7.1].define(version: 20251007123729) do
  create_table "facts", force: :cascade do |t|
    t.text "fact"
    t.integer "likes", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
