class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string "username", default: "", null: false
      t.text "note"
      t.string "display_name", default: "", null: false
      t.string "avatar_file_name"
      t.string "avatar_content_type"
      t.integer "avatar_file_size"
      t.datetime "avatar_updated_at"
      t.string "header_file_name"
      t.string "header_content_type"
      t.integer "header_file_size"
      t.datetime "header_updated_at"
      t.boolean "silenced", default: false, null: false
      t.boolean "suspended", default: false, null: false
      t.boolean "locked", default: false, null: false
      t.integer "statuses_count", default: 0, null: false
      t.integer "followers_count", default: 0, null: false
      t.integer "following_count", default: 0, null: false

      t.timestamps null: false
    end

    add_foreign_key "users", "accounts", on_delete: :cascade
  end
end
