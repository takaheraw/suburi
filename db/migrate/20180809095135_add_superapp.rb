class AddSuperapp < ActiveRecord::Migration[5.2]
  def change
    add_column :oauth_applications, :superapp, :boolean, default: false, null: false
    add_foreign_key :oauth_access_tokens, :users, column: :resource_owner_id, on_delete: :cascade
  end
end
