class RemoveForeignKeyFromChatUsers < ActiveRecord::Migration[7.1]
  def change
    if foreign_key_exists?(:chat_users, :users)
      remove_foreign_key :chat_users, :users
    end
  end
end
